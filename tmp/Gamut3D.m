% Gamut Wire Frame

clear;
close all;
clc;

%% Create RGB Data
itv = 17;
[r, g, b] = meshgrid(0:itv:255, 0:itv:255, 0);
rgbfull = [r(:) g(:) b(:)];

% rgbfull = ...
% 	vertcat([r(:) g(:) b(:)], [r(:) b(:) g(:)], [g(:) r(:) b(:)],...
% 	[g(:) b(:) r(:)], [b(:) r(:) g(:)], [b(:) g(:) r(:)]);


%% RGB to CIE L*a*b* Conversion
labfull = sRGB2CIELAB(double(rgbfull)/255);

%% Filter Data (If Necessary)
onoff = false;
if onoff == true
	maxL = 80 + 1/2;
	minL = 80 - 1/2;
	mask = (labfull(:,1) < maxL) & (labfull(:,1) > minL);
	labfull(~mask, :) = [];
	rgbfull(~mask, :) = [];
end


%% Plot Data
tri = delaunay(labfull(:,2), labfull(:,3));
trisurf(tri, labfull(:,2), labfull(:,3), labfull(:,1));
xlabel('a*');	ylabel('b*');	zlabel('L*');
% scatter3(labfull(:,2), labfull(:,3), labfull(:,1), ...
% 	10, rgbfull/255, 'filled');
% hold on;
% K = convhull(labfull(:,2), labfull(:,3));
% plot(labfull(K,2), labfull(K,3), 'r-', 'LineWidth', 2);
view(0, 90);
daspect([1 1 1]);
% surf(0:itv:255, 0:itv:255, reshape(labfull(:,1), 18, 18), reshape(rgbfull, 18, 18, 3)/255)
% plot3(labfull(:,2), labfull(:,3), labfull(:,1));