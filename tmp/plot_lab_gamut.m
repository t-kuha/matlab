
%% Load image
rgb = imread('peppers.png');
% imshow(rgb)

%% Draw gamut boundary
[r,g,b] = meshgrid(linspace(0,1,20));
tmp = [r(:), g(:), b(:)];
lab = rgb2lab(tmp);
a = lab(:,2);
b = lab(:,3);
L = lab(:,1);
k = boundary(a, b, L, 0);
trisurf(k, a, b, L, ...
	'FaceColor', 'interp', 'FaceVertexCData', tmp, 'EdgeColor', 'none', ...
	'facealpha', 0.4)
xlabel('a*')
ylabel('b*')
zlabel('L*')
axis([-110 110 -110 110 0 100])
view(-10, 35)
axis equal
% title('sRGB gamut surface in L*a*b* space')

%% RGB の点をPlot
% まず，重複した点を削除 -> L*a*b* に
[rgbu, ~, ic] = ...
	unique(reshape(rgb, size(rgb,1)*size(rgb,2), size(rgb,3)), 'rows');
lab = rgb2lab(rgbu);

hold on;

plot3(lab(:,2), lab(:,3), lab(:,1), '.', ...
	'MarkerEdgeColor', [.8 .8 .8]);

hold off;

%% おまけ
t = [255 7 15];

h = histcounts(ic, (1:size(rgbu,1)+1)-0.5);
idx = find(rgbu(:,1) == t(1) & rgbu(:,2) == t(2) & rgbu(:,3) == t(3));

if isempty(idx)
	fprintf('\t (R,G,B) = (%d,%d,%d) has 0 pixel...\n', ...
		t(1), t(2), t(3));
else
	fprintf('\t (R,G,B) = (%d,%d,%d) has %d pixels...\n', ...
		t(1), t(2), t(3), h(idx));
end
