% ============================================================================
% A Particle record.  Records in Erlang are like structs in C.
% Unlike Erlang tuples they:
% - have named "fields", 
% - support default values for fields, and
% - support creating new records by changing just some elements,
%   while copying the others from an existing record.
% ============================================================================
-record(particle, {
	x, y,          % the x and y coordinates of the particle's position
	xVel = 0.0,    % the x and y components of the particle's ...
	yVel = 0.0,    % ... velocity
	mass = 1.0,    % the particle's mass
	radius = 1.0,  % the particle's radius
	lastUpdate     % the time-stamp at which the particle was last ...
	               % ... updated
}).

