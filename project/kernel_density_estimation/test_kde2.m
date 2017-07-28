% Kernel Density Estimation

ccc;

%% Load data from 'data.mat'
load('.\meanshift\data.mat');
data = [x1, x2];
clear x1 x2;

%  or...
% data = randn(200,2);

%%
h = 0.8;
N = size(data,1);
datanum = 200;	% Grid size

% Standard normal distribution
norm_dist = @(x1, x2) exp(-(x1.*x1 + x2.*x2)/2)/(2*pi);

% Optimal h
%h = 1.06*std(data)*N^(-1/5);
[x1, x2] = meshgrid(...
	linspace(min(data(:,1))-1, max(data(:,1))+1, datanum), ...
	linspace(min(data(:,2))-1, max(data(:,2))+1, datanum));

xx1 = (repmat(x1(:), 1, N) - repmat(data(:,1)', numel(x1), 1))/h;
xx2 = (repmat(x2(:), 1, N) - repmat(data(:,2)', numel(x2), 1))/h;

y = norm_dist(xx1, xx2);
y2 = reshape(sum(y,2)/(N*h), size(x1));


%% 
figure;

% for k = 1:N
% 	hnd = contour(x1, x2, reshape(sum(y(:,k),2)/(N*h), size(x1)));
% 	daspect([1 1 1]);
% 	pause(0.05);
% end

% surf(x1, x2, y2*100, 'LineStyle', 'none', 'AlphaData', 0.5);

hold on;
contour(x1, x2, y2, 12);

% Original data
plot(data(:,1), data(:,2), 'o', 'MarkerSize', 3, 'Color', [0.9, 0.1, 0.2]);    

hold off;
daspect([1 1 1]);


%% Check
% ‚±‚ê‚ª1‚É‹ß‚­‚È‚Á‚Ä‚¢‚é‚±‚Æ
disp(...
	(max(data(:,1)) - min(data(:,1)) + 2)/datanum*...
	(max(data(:,2)) - min(data(:,2)) + 2)/datanum*sum(y2(:)));

