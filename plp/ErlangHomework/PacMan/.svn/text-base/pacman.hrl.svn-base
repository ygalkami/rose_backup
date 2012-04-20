% ----------------------------------------------------------------
% Defines records used in the game.
% ----------------------------------------------------------------

-record(sprite, {
	x, y,					% Sprite's position, in pixels
	heading = right,		% One of left, right, up, or down
	imageIndex = 1,			% An index into the image file list
	rightImageFiles = [],	% A list of filenames of the image gifs
	leftImageFiles = [],	% A list of filenames of the image gifs
	upImageFiles = [],		% A list of filenames of the image gifs
	downImageFiles = [],	% A list of filenames of the image gifs
	currentImageFile,		% The filename of the current image gif
	imageObject				% a GS canvas image object (see section 8.9.2 of ...
							% ... the GS User's Guide)
}).
