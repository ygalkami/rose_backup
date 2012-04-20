% ----------------------------------------------------------------
% I've got Pac-Man Fever!
% ----------------------------------------------------------------
-module(pacman).
-compile(export_all).
-include("pacman.hrl").
-import(lists, [nth/2]).

% ----------------------------------------------------------------
% Nearly constants
% ----------------------------------------------------------------
gridSize() -> 20.
spriteSize() -> 2 * gridSize().


% ----------------------------------------------------------------
% Main entry point.	 Spawns the GUI.
start() -> 
	register(game, spawn(pacman, gui_helper, [])).
	
% Shuts down the game.
stop() -> game ! stop.

% Sets up the GUI. Configures the processes for the game.
gui_helper() ->
	WinWidth = gridSize() * board:width(),
	WinHeight = gridSize() * board:height(),
	GraphicsID = gs:start(),
	GameWindow = gs:create(window, GraphicsID,
					[{title, "Pac-Man"},
					 {width, WinWidth}, {height, WinHeight},
					 {keypress, true}]),
	gs:create(canvas, gameCanvas, GameWindow,
		[{x,0}, {y,0}, {width, WinWidth}, {height, WinHeight}, {bg, black}]),
	paintBoard(),
	spawnPacMan(),
	gs:config(GameWindow, {map, true}),
	gui_loop(),
	ok.

% The main GUI loop.
gui_loop() ->
	receive
		{gs, _, keypress, _, [Key|_]} -> 
			handle(Key),
			gui_loop();
		{gs, _, destroy, _, _} ->
			gs:stop(),
			exit(windowClosed);
		stop -> 
			gs:stop(),
			exit(gameover);
		_Any ->
			io:format("GUI Received: ~w~n", [_Any]),
			gui_loop()
	end.

% Keypress handlers
handle('Up') -> pacman ! {self(), {turn, up}};
handle('Down') -> pacman ! {self(), {turn, down}};
handle('Left') -> pacman ! {self(), {turn, left}};
handle('Right') -> pacman ! {self(), {turn, right}};
handle(q) -> game ! stop;
handle(Key) ->
	io:format("Unhandled keypress: ~w~n", [Key]).
	
% ----------------------------------------------------------------
% Paints the background
paintBoard() ->	paintRows(board:height()).
paintRows(0) -> paintColumns(0, board:width());
paintRows(R) -> 
	paintColumns(R, board:width()),
	paintRows(R-1).
paintColumns(R, 0) -> paintCell(R, 0);
paintColumns(R, C) -> 
	paintCell(R, C),
	paintColumns(R, C-1).
paintCell(R, C) ->
	case board:isBlocked(R,C) of
		true -> 
			Size = gridSize(),
			X = C * Size,
			Y = R * Size,
			gs:create(rectangle, gameCanvas,
						[{coords, [{X, Y}, {X+Size, Y+Size}]},
						 {bw, 0},
						 {fill, blue}]);
		false -> ok
	end.
			

% ----------------------------------------------------------------
% Configures and spawns a process for controlling Pac-Man
spawnPacMan() ->
	PacManImage = gs:create(image, gameCanvas, []),
	PacMan = #sprite{ 
		x = 0,
		y = 0,
		% FIXME: new glyphs
		rightImageFiles = ["pmClosed.gif", "pmRight1.gif", "pmRight2.gif", "pmRight3.gif"],
		leftImageFiles = ["pmClosed.gif", "pmLeft1.gif", "pmLeft2.gif", "pmLeft3.gif"],
		upImageFiles = ["pmClosed.gif", "pmUp1.gif", "pmUp2.gif", "pmUp3.gif"],
		downImageFiles = ["pmClosed.gif", "pmDown1.gif", "pmDown2.gif", "pmDown3.gif"],
		currentImageFile = "pmClosed.gif",
		imageObject = PacManImage
	},
	register(pacman, spawn_link(pacman, pacManLoop, [PacMan, 0])),
	spawn_link(pacman, heartbeat, [25, whereis(pacman)]),
	whereis(pacman).

% The loop controlling the PacMan character.  PacMan is a sprite record.
% N is a modulo counter used to track when the image should change to a
% different gif.
pacManLoop(PacMan, N) ->
	MoveRate = 3,
	ImageStep = 4,
	gs:config(PacMan#sprite.imageObject, 
			  [{coords, [{PacMan#sprite.x, PacMan#sprite.y}]},
			   {load_gif, PacMan#sprite.currentImageFile}]),
	GuiPID = whereis(game),
	receive
		beat ->
			PacMan_ = if 
						N == 0 -> nextImage(PacMan);
						true -> PacMan
					  end,
			PacMan__ = move(MoveRate, PacMan_),
			pacManLoop(PacMan__, (N+1) rem ImageStep);
		{GuiPID, {turn, Dir}} ->
			pacManLoop(PacMan#sprite{heading=Dir}, N);
		_Any -> 
			io:format("pacMapLoop, unexpected message: ~w~n", [_Any]),
			pacManLoop(PacMan, N)
	end.

% ----------------------------------------------------------------
% Updates the coordinates of the given sprite by the given amount
% based on the sprite's heading.
move(Rate, Sprite) ->
	X = Sprite#sprite.x,
	Y = Sprite#sprite.y,
	case Sprite#sprite.heading of
		right -> Sprite#sprite{x=X+Rate};
		left -> Sprite#sprite{x=X-Rate};
		up -> Sprite#sprite{y=Y-Rate};
		down -> Sprite#sprite{y=Y+Rate}
	end.
	
% ----------------------------------------------------------------
% Updates the current image of the given sprite based on the
% image index and heading.
nextImage(Sprite) ->
	ImageFileList = case Sprite#sprite.heading of
		right -> Sprite#sprite.rightImageFiles;
		left -> Sprite#sprite.leftImageFiles;
		up -> Sprite#sprite.upImageFiles;
		down -> Sprite#sprite.downImageFiles
	end,
	N = length(ImageFileList),
	% grr, lists in Erlang are 1-indexed
	Index = Sprite#sprite.imageIndex - 1,
	Index_ = ((Index + 1) rem N) + 1,
	Sprite#sprite{imageIndex = Index_, 
				  currentImageFile = nth(Index_, ImageFileList)}.

% ----------------------------------------------------------------
% Sends a 'beat' message to the process with the given PID every
% Interval milliseconds.
heartbeat(Interval, PID) ->
	receive
	after Interval ->
		PID ! beat
	end,
	heartbeat(Interval, PID).
