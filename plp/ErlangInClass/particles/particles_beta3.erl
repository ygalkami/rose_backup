% ============================================================================
% A module giving initial code toward an n-body problem simulator.
% ============================================================================
-module(particles_beta3).
% TODO: add legitimate -export() attribute
-compile(export_all). % <--- for development/testing
% Include the particle record.
-include("particles.hrl").

% ============================================================================
% Main server functions
% ============================================================================

% ----------------------------------------------------------------------------
% Listens for incoming requests, updates "state", and repeats.
particle_loop(Particle, FixedMass) ->
	receive
		{whereAreYou, Inquistor} ->
			P2 = update_position(Particle, FixedMass, now()),
			Inquistor ! {self(), {position, P2#particle.x, P2#particle.y}},
			particle_loop(P2, FixedMass);
		{poof, Executioner} ->
			Executioner ! {self(), {poof}}; 
		% Receives any unmatched incoming messages.  Useful for 
		% debugging:
		_Unknown ->
			io:format("Received unknown message: ~p~n", [_Unknown]),
			particle_loop(Particle, FixedMass)
	end.

% ----------------------------------------------------------------------------
% Creates a particle motion process for a random particle about a fixed mass
% of mass M.  Returns the Pid.
launch_particle(M) ->
	P = random_particle(),
	FM = fixed_mass(M),
	spawn(particles_beta3, particle_loop, [P,FM]).

% ----------------------------------------------------------------------------
% Asks the particle at the given process what its position is.
where(Pid) ->
	Pid ! {whereAreYou, self()},
	receive
		{Pid, {position, _X, _Y}=Answer} -> Answer;
		_Unknown ->	io:format("Received unknown message: ~p~n", [_Unknown])
	end.

% ----------------------------------------------------------------------------
% Destroy the particle at the given process.
poof(Pid) ->
	Pid ! {poof, self()},
	receive
		{Pid, {poof}} -> ok;
		_Unknown ->	io:format("Received unknown message: ~p~n", [_Unknown])
	end.

% ----------------------------------------------------------------------------
% Prints the position of the particle at the given process.
print_where(Pid) ->
	{position, X, Y} = where(Pid),
	io:format("At [~.4f, ~.4f]~n", [X,Y]).

% ============================================================================
% Functions for manipulating particle records.
% ============================================================================

% ----------------------------------------------------------------------------
% Creates a new particle representing a fixed mass.
fixed_mass(M) ->
	#particle{x=0.0, y=0.0, mass=M, lastUpdate=now()}.

% ----------------------------------------------------------------------------
% Creates a new particle with a random initial position and velocity.
random_particle() ->
	MaxPosComponent = 100.0,
	MaxVelComponent = 5.0,
	X = get_random_component(MaxPosComponent),
	Y = get_random_component(MaxPosComponent),
	XVel = get_random_component(MaxVelComponent),
	YVel = get_random_component(MaxVelComponent),
	time_stamp(#particle{x=X, y=Y, xVel=XVel, yVel=YVel}).

% ----------------------------------------------------------------------------
% Updates the time-stamp of the given particle.
time_stamp(P1) -> P1#particle{lastUpdate = now()}.

% ----------------------------------------------------------------------------
% Updates the position of the given particle under the gravitational
% influence of the given fixed mass, based on the elapsed time between the
% given time and the time stamp of the particle.
update_position(Particle, FixedMass, NewTime) ->
	{XForce, YForce} = force(FixedMass, Particle),
	PMass = Particle#particle.mass,
	{XAccel, YAccel} = {XForce/PMass, YForce/PMass},
	ElapsedTime = time_difference(Particle#particle.lastUpdate, NewTime),
	NewX = Particle#particle.x + Particle#particle.xVel * ElapsedTime,
	NewY = Particle#particle.y + Particle#particle.yVel * ElapsedTime,
	NewXVel = Particle#particle.xVel + XAccel * ElapsedTime,
	NewYVel = Particle#particle.yVel + YAccel * ElapsedTime,
	Particle#particle{x=NewX, y=NewY, 
					  xVel=NewXVel, yVel=NewYVel, 
					  lastUpdate=NewTime}.

% ----------------------------------------------------------------------------
% Calculates the gravitational attraction between two particles using Newton's
% law.  Returns a pair giving the x- and y-components of the force assuming 
% the first particle is fixed.
force(P1,P2) ->
	G = 1.0,
	{Run, Rise, R} = distance(P1, P2),
	Mag = G * P1#particle.mass * P2#particle.mass / (R*R),
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

