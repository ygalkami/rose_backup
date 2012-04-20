% ============================================================================
% A module giving initial code toward an n-body problem simulator.
% ============================================================================
-module(particles).
% TODO: add legitimate -export() attribute
-compile(export_all). % <--- for development/testing
% Include the particle record.
-include("particles.hrl").

% ============================================================================
% Nearly constants
% ============================================================================

% ----------------------------------------------------------------------------
% The default time step for a particle in milliseconds.
default_time_step() -> 25.
max_time_step() -> 50.

% ============================================================================
% Main server functions
% ============================================================================

% ----------------------------------------------------------------------------
% Simulates a single particle, by listens for incoming requests for data,
% and requesting that the given "force server" occasionally send updated
% force messages that affect the particles state.
% FIXME: The ForceServer design is probably unnecessarily complex, if each 
% particle knows about all the others, it could periodically ask the other
% to nudge it.  Would need to change the time step update to make the step
% small after larger acceleration, but then decay slowly back to the max time
% step.  Otherwise a large acceleration followed by a small one would result 
% in switching to too large a time step.  Also, consider having the particles 
% report updates to the GUI instead of the GUI polling the particles.
% CHALLENGE: the accumulated change in velocity of each nudge is a function of
% time!
particle_loop(Particle, ForceServer) ->
	particle_loop(Particle, ForceServer, false).
particle_loop(Particle, ForceServer, Moving) ->
	receive
		% FIXME: standardize message format {senderPid, msg}
		{startMoving, Director} when not Moving ->
			Director ! {self(), {moving}},
			% io:format("~p Movin' on up~n", [self()]),
			P2 = time_stamp(Particle),
			ForceServer ! {self(), {updateNeeded}},
			particle_loop(P2, ForceServer, Moving);
		{startMoving, Director} when Moving ->
			Director ! {self(), {alreadyMoving}},
			particle_loop(Particle, ForceServer, Moving);
		{ForceServer, {feelTheForce, XAccel, YAccel, When}} ->
			P2 = update_position(Particle, XAccel, YAccel, When),
			Mag = math:sqrt(XAccel*XAccel + YAccel*YAccel),
			CalcTS = trunc(default_time_step() / (Mag * Mag)),
			TimeStep = lists:max([CalcTS, max_time_step()]),
			erlang:send_after(TimeStep, ForceServer, 
								{self(), {updateNeeded}}),
			particle_loop(P2, ForceServer, Moving);
		{reportStatus, Inquistor} ->
			Inquistor ! {self(), 
				{status, Particle#particle.x, Particle#particle.y, 
				 Particle#particle.radius}},
			particle_loop(Particle, ForceServer, Moving);
		{reportDetails, Inquistor} ->
			Inquistor ! {self(), {details, Particle}},
			particle_loop(Particle, ForceServer, Moving);
		{Executioner, {poof}} ->
			Executioner ! {self(), {exiting}}; 
		% Receives any unmatched incoming messages.  Useful for 
		% debugging:
		_Unknown ->
			io:format("particle_loop received unknown message: ~p~n", 
						[_Unknown]),
			particle_loop(Particle, ForceServer, Moving)
	end.

% ----------------------------------------------------------------------------
% A manager for receiving requests from particles to calculate forces,
% delegating the calculations to new processes, and relaying the results back
% to the particles.
force_server_loop() -> force_server_loop([]).
force_server_loop(PartPids) ->
	receive
		{Creator, {haveSomeParticles, NewPids}} when PartPids =:= [] ->
			Creator ! {self(), {gotEm}},
			force_server_loop(NewPids);
		{_, {haveSomeParticles, _}} when PartPids =/= [] ->
			io:format("force_server_loop received unexpected particles:~n"),
			force_server_loop(PartPids);
		{ParticlePid, {updateNeeded}} ->
			Others = PartPids -- [ParticlePid],
			spawn(particles, force_reporter, [self(), ParticlePid, Others]),
			force_server_loop(PartPids);
		{_Delegate, {forceReport, ParticlePid, Report}} ->
			ParticlePid ! {self(), Report},
			force_server_loop(PartPids);
		{Executioner, {poof}} ->
			lists:foreach(fun poof/1, PartPids),
			Executioner ! {self, {exiting}};
		_Unknown ->
			io:format("force_server_loop received unknown message: ~p~n", 
						[_Unknown]),
			force_server_loop(PartPids)
	end.

% ----------------------------------------------------------------------------
% Handles integration of forces on a single particle based on the masses and
% positions of the other particles in the system.
force_reporter(ForceServer, PartPid, OthersPids) ->
	Particle = get_particle(PartPid),
	AccelComponents = 
		[accel(get_particle(OtherPid), Particle) 
			|| OtherPid <- OthersPids],
	{XAccel, YAccel} = 
		lists:foldr(fun ({X,Y}, {AccX, AccY}) -> {AccX+X, AccY+Y} end, 
					{0,0}, AccelComponents),
	Report = {feelTheForce, XAccel, YAccel, now()},
	ForceServer ! {self(), {forceReport, PartPid, Report}}.

% ----------------------------------------------------------------------------
% Creates a particle motion process for a N random particles.  Returns a pair 
% of the force server PID and a list of the particle Pids.
launch_particles(N) ->
	FSPid = spawn(particles, force_server_loop, []),
	Pids = [spawn(particles, particle_loop, [random_particle(), FSPid]) || 
				_ <- lists:seq(1,N)],
	FSPid ! {self(), {haveSomeParticles, Pids}},
	receive
		{FSPid, {gotEm}} -> 
			io:format("Activating particles...~n"),
			lists:foreach(fun(Pid) -> Pid ! {startMoving, self()} end, Pids),
			{FSPid, Pids}
	after 1000 ->
		io:format("Force server did not acknowledge receiving particles!~n"),
		lists:foreach(fun poof/1, Pids),
		poof(FSPid),
		throw({forceServerInitFailure})
	end.


% ----------------------------------------------------------------------------
% Asks the particle at the given process what its position is.
where(Pid) ->
	Pid ! {reportStatus, self()},
	receive
		{Pid, {status, _X, _Y, _Radius}=Answer} -> Answer;
		_Unknown ->	io:format("where received unknown message: ~p~n", [_Unknown])
	end.

% ----------------------------------------------------------------------------
% Gets the particle record for the particle at the given process ID.
get_particle(Pid) ->
	Pid ! {reportDetails, self()},
	receive
		{Pid, {details, P}} -> P
		% No case for unknown here since each particle might be asking for
		% anothers information, so details and reportDetails messages are
		% both in the mailbox simulataneously
	end.

% ----------------------------------------------------------------------------
% Destroy the particle at the given process.
poof(Pid) -> Pid ! {self(), {poof}}.

% ----------------------------------------------------------------------------
% Prints the position of the particle at the given process.
print_where(Pid) ->
	{status, X, Y, _Radius} = where(Pid),
	io:format("At [~.4f, ~.4f]~n", [X,Y]).

% ----------------------------------------------------------------------------
% Prints the position of the particle at the given process every Tick 
% milliseconds.  Returns a process id that can be sent a "shut up" message
% to stop the process.
periodic_print(Pid, Tick) ->
	spawn(particles, periodic_print_helper, [Pid, Tick]).
periodic_print_helper(Pid, Tick) ->
	print_where(Pid),
	receive
		{shutup} -> io:format("Shutting up~n", []);
		_Unknown ->	
			io:format("periodic_print_helper received unknown message: ~p~n", 
						[_Unknown])
	after Tick ->
		periodic_print_helper(Pid, Tick)
	end.

% ============================================================================
% Functions for GUI display.
% ============================================================================

% ----------------------------------------------------------------------------
% Simplest entry point for a GUI display.
gui(N) ->
	{FS,Pids} = launch_particles(N),
	% FIXME: need to register to find out about gui process death so we
	% can shut down the particles and force server also.
	spawn_gui(FS,Pids).

% ----------------------------------------------------------------------------
% Creates a GUI for displaying the particles with the given Pids.
spawn_gui(ForceServer, PartPids) ->
	spawn(particles, gui_helper, [ForceServer, PartPids]).
gui_helper(FSPid, PartPids) ->
	WinWidth = 800,
	WinHeight = 600,
	GraphicsID = gs:start(),
	gs:create(window, partWindow, GraphicsID, 
					[{title, "Particle Man"},
					{width, WinWidth}, {height, WinHeight}]),
	gs:create(canvas, partCanvas, partWindow, 
		[{x,0}, {y,0}, {width, WinWidth}, {height, WinHeight}, {bg, black}]),
	OvalPidPairs = [{gs:create(oval, partCanvas, [{fill, red}]), P} 
						|| P <- PartPids],
	lists:foreach(fun gui_set_particle_coords/1, OvalPidPairs),
	gs:config(partWindow, {map, true}),
	gui_loop(FSPid, OvalPidPairs),
	ok.

gui_loop(FSPid, OvalPidPairs) ->
	TimeStep = default_time_step(),
	lists:foreach(fun gui_set_particle_coords/1, OvalPidPairs),
	receive
		{gs, _, destroy, _, _} ->
			% exits loop when window is closed
			io:format("Exiting GUI loop because window was closed.~n", []),
			poof(FSPid),
			ok;
		Any -> 
			io:format("GUI Received: ~w~n", [Any]),
			gui_loop(FSPid, OvalPidPairs)
	after TimeStep -> gui_loop(FSPid, OvalPidPairs)
	end.
	
gui_set_particle_coords({Oval, Pid}) ->
	{status, X, Y, Radius} = where(Pid),
	WinWidth = gs:read(partWindow, width),
	WinHeight = gs:read(partWindow, height),
	% Translate displayed coordinates to put origin in window center
	OX = trunc(X + WinWidth / 2),
	OY = trunc(Y + WinHeight / 2),
	TLX = OX - Radius,
	TLY = OY - Radius,
	BRX = OX + Radius,
	BRY = OY + Radius,
	gs:config(Oval, [{coords, [{TLX, TLY}, {BRX, BRY}]}]),
	ok.

% ============================================================================
% Functions for manipulating particle records.
% ============================================================================

% ----------------------------------------------------------------------------
% Creates a new particle with a random initial position and velocity.
random_particle() ->
	MaxPosComponent = 300.0,
	MaxVelComponent = 25.0,
	MaxMass = 60000,
	X = get_random_component(MaxPosComponent),
	Y = get_random_component(MaxPosComponent),
	XVel = get_random_component(MaxVelComponent),
	YVel = get_random_component(MaxVelComponent),
	Mass = abs(get_random_component(MaxMass)),
	% Rough approximation of the radius of a sphere with volume == Mass
	Radius = trunc(cube_root(Mass/4)),
	time_stamp(#particle{x=X, y=Y, xVel=XVel, yVel=YVel, 
						 mass=Mass, radius=Radius}).

% ----------------------------------------------------------------------------
% Updates the time-stamp of the given particle.
time_stamp(P1) -> P1#particle{lastUpdate = now()}.


% ----------------------------------------------------------------------------
% Updates the position of the given particle under the given acceleration
% for the time elapsed between the particles time-stamp and the given time.
update_position(Particle, XAccel, YAccel, NewTime) ->
	ElapsedTime = time_difference(Particle#particle.lastUpdate, NewTime),
	NewX = Particle#particle.x + Particle#particle.xVel * ElapsedTime,
	NewY = Particle#particle.y + Particle#particle.yVel * ElapsedTime,
	NewXVel = Particle#particle.xVel + XAccel * ElapsedTime,
	NewYVel = Particle#particle.yVel + YAccel * ElapsedTime,
	Particle#particle{x=NewX, y=NewY, 
					  xVel=NewXVel, yVel=NewYVel, 
					  lastUpdate=NewTime}.

% ----------------------------------------------------------------------------
% Calculates the gravitational acceleration between two particles using Newton's
% law.  Returns a pair giving the x- and y-components of the acceleration
% imposed on the second particle.
accel(P1,P2) ->
	G = 4.0,
	{Run, Rise, R} = distance(P1, P2),
	Mag = G * P1#particle.mass / (R*R),
	{Run*Mag/R, Rise*Mag/R}.

% ----------------------------------------------------------------------------
% Calculates the distance between two particles, returning a triple of the
% x distance, y distance, and Euclidean distance.
distance(P1,P2) ->
	Xd = P1#particle.x - P2#particle.x,
	Yd = P1#particle.y - P2#particle.y,
	{Xd, Yd, math:sqrt(Xd*Xd + Yd*Yd)}.

% ============================================================================
% Some helper functions that are less interesting than the new stuff above.
% ============================================================================

% ----------------------------------------------------------------------------
% Seeds the random number generator using the current time.
seed() -> 
	{T1, T2, T3} = now(),
	random:seed(T1,T2,T3).

% ----------------------------------------------------------------------------
% Returns a new random float uniformly distributed between -1.0 and 1.0.  
% Seeds the random number generated using the current time if it hasn't yet
% been seeded for this process. Uses the process dictionary, and the key 
% particles_seeded, to record that seeding has been done.
get_random_component(Max) ->
	case get(particles_seeded) of
		undefined ->
			seed(),
			put(particles_seeded, true);
		_ -> ok
	end,
	random:uniform() * 2.0 * Max - Max.
	
% ----------------------------------------------------------------------------
% Calculates the time difference in seconds between the first and second
% times. Both times are in the format returned by the now() BIF.
time_difference(T1, T2) ->
	Time1 = micro_time(T1),
	Time2 = micro_time(T2),
	(Time2 - Time1) / 1000000.
	
			
% ----------------------------------------------------------------------------
% Converts the time triple, as returned by the now() BIF, into an integer
% number of microseconds.
micro_time({Mega,Sec,Micro}) ->
	M = 1000000,
	Mega*M*M + Sec*M + Micro.

% ----------------------------------------------------------------------------
% Uses Newton's method to calculate the cube_root of N to within 0.25.
cube_root(N) ->
	Guess = math:sqrt(N),
	cube_root(N, Guess, N, 0.25).
cube_root(_Original, Guess, OldGuess, Epsilon) 
	when abs(Guess - OldGuess) < Epsilon -> Guess;
cube_root(Original, Guess, _OldGuess, Epsilon) ->
	NewGuess = (2*Guess + Original/(Guess * Guess)) / 3,
	cube_root(Original, NewGuess, Guess, Epsilon).
	
	

