% x = gallery('uniformdata',30,1,1);

[x, y] = gallery('uniformdata',30,1,2);
plot(x,y,'.')
axis([-0.2 1.2 -0.2 1.2])
axis equal


k = boundary(x, y);
hold on
plot(x(k),y(k))
hold off

k0 = boundary(x,y,0);
k1 = boundary(x,y,1);
hold on
plot(x(k0),y(k0))
plot(x(k1),y(k1))
hold off
legend('Original points','Shrink factor: 0.5 (default)',...
    'Shrink factor: 0','Shrink factor: 1')

%%
P = gallery('uniformdata',30,3,5);
plot3(P(:,1),P(:,2),P(:,3),'.','MarkerSize',10)
grid on

k = boundary(P);
hold on
trisurf(k,P(:,1),P(:,2),P(:,3),'Facecolor','red','FaceAlpha',0.1)
hold off

%%


%% 
[r,g,b] = meshgrid(linspace(0,1,20));
rgb = [r(:), g(:), b(:)];
lab = rgb2lab(rgb);
a = lab(:,2);
b = lab(:,3);
L = lab(:,1);
k = boundary(a, b, L, 0);
trisurf(k, a, b, L, ...
	'FaceColor', 'interp', 'FaceVertexCData', rgb, 'EdgeColor', 'none', ...
	'facealpha', 0.3)
xlabel('a*')
ylabel('b*')
zlabel('L*')
axis([-110 110 -110 110 0 100])
view(-10, 35)
axis equal
title('sRGB gamut surface in L*a*b* space')

%% RGB の点をPlot
rgb = imread('peppers.png');
% imshow(rgb)

% まず，重複した点を削除
rgbu = unique(reshape(rgb, size(rgb,1)*size(rgb,2), size(rgb,3)), 'rows');

% L*a*b* に
lab = rgb2lab(rgbu);
hold on;

hLine = plot3(lab(:,2), lab(:,3), lab(:,1), '.', ...
	'MarkerEdgeColor', [.8 .8 .8]);
% hMarkers = hLine.MarkerHandle;
% hMarkers.FaceColorData = uint8(255*[.7;.7;.7;0.3]);

% for k = 1:100:size(rgbu,1)
% plot3(lab(k,2), lab(k,3), lab(k,1), '.', ...
% 	'MarkerEdgeColor', double(rgbu(k,:))/255);
% end

hold off;

% figure
% trimesh(k, a, b, L);
