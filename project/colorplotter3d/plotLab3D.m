%% L*a*b* 3D plot


%% Main function
% handle:	handle to graph
% lab:		Measured L*a*b* data
% lab0:		Reference L*a*b* data
function plotLab3D(varargin)

%% Paese input
switch(nargin)
	case 0
		% In case of no input:		Do nothing & return
		error('Error (in plotLab3D() )...');
		
	case 1
		% When handle to the graph is not specified:
		% Create external window & plot there
		fig1 = figure;
		handleGraph = axes('Parent', fig1, ...
			'FontName', 'Verdana', 'FontSize', 8, 'Color', 'white');
		lab1 = varargin{1};
		lab0 = [];
		
	case 2
		% Handle graphics & 1 set of data (measured data only)
		handleGraph = varargin{1};
		set(handleGraph, ...
			'FontName', 'Verdana', 'FontSize', 8, 'Color', 'white');
		lab1 = varargin{2};
		lab0 = [];
		
	case 3
		% Handle & 2 sets of data (measured & reference)
		% GUI ver. ÇÕäÓñ{ìIÇ…Ç±Ç±Ç…ÇµÇ©óàÇ»Ç¢
		handleGraph = varargin{1};
		set(handleGraph, ...
			'FontName', 'Verdana', 'FontSize', 8, 'Color', 'white');
		lab1 = varargin{2};
		lab0 = varargin{3};
		
	otherwise
		error('Too many inputs...');
end

% Clear exisiting plot
cla(handleGraph);

% Setting
d = 2;		% Data point size

% set(gcf,	'PaperPositionMode', 'auto');

% Check data size
% if(isempty(lab0) == 0)
% 	[h w ~] = size(lab);
% 	[h0 w0 ~] = size(lab0);
% 	if( (h ~= h0) || (w ~= w0) )
% 		clear h w h0 w0;
% 		errordlg('Input data sizes must be the same...', 'Invalid input data');
% 		return;
% 	end
% end

% Enable axis (ìÆÇ©ÇµÇΩÇ∆Ç´Ç…ñ⁄ê∑ìrêÿÇÍÇ»Ç¢ÇÊÇ§Ç…)
aMax = 160;		aMin = -160;
bMax = 160;		bMin = -160;
LMax = 100;		LMin = 0;
xlim(handleGraph, [-100 100]);	% Initial value
ylim(handleGraph, [-100 100]);
zlim(handleGraph, [LMin LMax]);		% L*
set(handleGraph, 'xtick', aMin:20:aMax, 'xcolor', 'k');
set(handleGraph, 'ytick', bMin:20:bMax, 'ycolor', 'k');
set(handleGraph, 'ztick', LMin:20:LMax);

% Show grids
grid(handleGraph, 'on');


% Plot
cform = makecform('lab2srgb');

% Measured data (lab1)
if ~isempty(lab1)
	rgb = applycform(lab1, cform);
	drawPointVec(lab1(:,2), lab1(:,3), lab1(:,1), d, rgb, 0);
	% scatter3(lab(:,2), lab(:,3), lab(:,1), 'sb', 'filled');
end

% Reference data (;ab0)
if ~isempty(lab0)
	rgb0 = applycform(lab0, cform);
	drawPointVec(lab0(:,2), lab0(:,3), lab0(:,1), d, rgb0, 1);
end

% Arrow
[h1, w1, ~] = size(lab1);
[h0, w0, ~] = size(lab0);
if( (h1 == h0) && (w1 == w0) )
	% If both data have the same num of data...
	% draw arrows	
	hold on;
	quiver3(lab0(:,2), lab0(:,3), lab0(:,1), ...
		lab1(:,2) - lab0(:,2), lab1(:,3) - lab0(:,3), lab1(:,1) - lab0(:,1), ...
		0, 'Color', [0.7 0.7 0.7]);
	hold off;	
end

% scatter3(lab0(:,2), lab0(:,3), lab0(:,1), 'og');

% Set labels
zlabel('L*', 'FontName', 'Verdana', 'FontSize', 10, 'FontWeight', 'bold');
xlabel('a*', 'FontName', 'Verdana', 'FontSize', 10, 'FontWeight', 'bold');
ylabel('b*', 'FontName', 'Verdana', 'FontSize', 10, 'FontWeight', 'bold');

% Initial viewing condition
daspect([1 1 1]);				% Aspect ratio
view(handleGraph, [0 90]);	% Direction (a*b* plot)

% Show
drawnow;


%% Draw Spheres & Cubes (vector version)
% Copyright 2007 The MathWorks, Inc.
% x:		x coordinates of a data point
% y:		y
% z:		z
% color:	color of data point
% type:	0 = sphere / otherwise = cube
function h = drawPointVec(x, y, z, r, color, type)
% type... 
hold on;

nData = length(x);
% 	xx = r*cosphi*cos(theta) + x(iData);
% 	yy = r*cosphi*sintheta + y(iData);
% 	zz = r*sin(phi)*ones(1, n+1) + z(iData);

if(type)
	% Spheres
	n = 20;	% precision of data points
	theta = (-n:2:n)/n*pi;
	phi = (-n:2:n)'/n*pi/2;
	cosphi = cos(phi); 
	cosphi(1) = 0; 
	cosphi(n+1) = 0;
	sintheta = sin(theta); 
	sintheta(1) = 0;
	sintheta(n+1) = 0;

	x0 = r*cosphi*cos(theta);
	y0 = r*cosphi*sintheta;
	z0 = r*sin(phi)*ones(1, n+1);
%  	grid on;
	for iData = 1:nData
		xx = x0 + x(iData);
		yy = y0 + y(iData);
		zz = z0 + z(iData);

 		h = patch(surf2patch(surf(xx, yy, zz)));

		set(h, 'FaceColor', color(iData,:), 'EdgeColor', color(iData,:));
	end
	
else
	% Cubes
	
	% Faces
	face = [	1 2 6 5;
				2 3 7 6;
				3 4 8 7;
				4 1 5 8;
				1 2 3 4;
				5 6 7 8];
	for iData = 1:nData
	
		xp = x(iData) + r;
		xm = x(iData) - r;
		yp = y(iData) + r;
		ym = y(iData) - r;
		zp = z(iData) + r;
		zm = z(iData) - r;
		% Vertices
		vrtx = [	xm, ym, zm;
					xp, ym, zm;
					xp, yp, zm;
					xm, yp, zm;
					xm, ym, zp;
					xp, ym, zp;
					xp, yp, zp;
					xm, yp, zp];

		h = patch('Vertices', vrtx, 'Faces', face, 'facealpha', .3);
		set(h, 'FaceColor', color(iData,:), 'EdgeColor', color(iData,:));
	end
end

hold off;

%{
%% Draw Spheres & Cubes
% Copyright 2007 The MathWorks, Inc.
% x:		x coordinates of a data point
% y:		y
% z:		z
% color:	color of data point
% type:	0 = sphere / otherwise = cube
% function h = drawPoint(x, y, z, r, color, type)
% % hold on
% 
% n = 20;
% theta = (-n:2:n)/n*pi;
% phi = (-n:2:n)'/n*pi/2;
% cosphi = cos(phi); 
% cosphi(1) = 0; 
% cosphi(n+1) = 0;
% sintheta = sin(theta); 
% sintheta(1) = 0;
% sintheta(n+1) = 0;
% 
% xx = r*cosphi*cos(theta) + x;
% yy = r*cosphi*sintheta + y;
% zz = r*sin(phi)*ones(1, n+1) + z;
% 
% if type
% 	h = patch(surf2patch(surf(xx,yy,zz)));
%  	edgeColor = color;
% else
% 	xp = x+r;
% 	xm = x-r;
% 	yp = y+r;
% 	ym = y-r;
% 	zp = z+r;
% 	zm = z-r;
% 	%Vertices
% 	verts = [xm, ym, zm;
% 				xp, ym, zm;
% 				xp, yp, zm;
% 				xm, yp, zm;
% 				xm, ym, zp;
% 				xp, ym, zp;
% 				xp, yp, zp;
% 				xm, yp, zp];
% 	%faces
% 	f1 = [1 2 6 5;
% 			2 3 7 6;
% 			3 4 8 7;
% 			4 1 5 8;
% 			1 2 3 4;
% 			5 6 7 8];
% 	h = patch('Vertices', verts, 'Faces', f1, 'facealpha', .2);
% end
% set(h, 'FaceColor', color, 'EdgeColor', edgeColor)
%}
