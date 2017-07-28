%% meanshift algorithm

%% Clear workspace
ccc;


%% Load data
load('.\meanshift\data.mat');
initdata = [x1, x2];	% 初期データ (plot用としてそのまま残す)
clear x1 x2;

% Standard normal distribution
norm_dist = @(x, sigma) ...
	exp(-0.5*sum(x.^2, 2)/(sigma.^2)) / (sqrt(2*pi)*sigma);

%% 
bw = 0.8;				% Band width
tor = 0.000001;			% 終了条件 (Tolerance)

data = initdata;		% 繰り返し毎に更新
olddata = data;			% 前回との距離の計算に使用

nite = 0;				% Num. of iterations
maxite = 1000;

%% Processing
tic;

while(nite < maxite)
	nite = nite + 1;	% Counter
		
% 	% 途中経過
% 	plot(data(:,1), data(:,2), 'o', 'MarkerSize', 4, ...
% 		'Color', [0.9, 0.1, 0.2]);
% 	daspect([1 1 1]);
% 	drawnow;
		
	for p = 1:size(data,1)
		tmp = data(p,:);		% Initial point

		% Gaussian Kernel
		w = norm_dist( repmat(tmp, size(data,1), 1) - initdata, bw );
		data(p,:) = sum(initdata.*repmat(w,1,2))./sum(w);
		
		% or... 
		% bw 以内に入った点を抽出 -> その平均位置を計算
% 		idx = sum((initdata - repmat(tmp, size(data,1), 1)).^2, 2) <= bw;
% 		data(p,:) = mean(initdata(idx, :));		
	end
	
	if max( sqrt( sum((data - olddata).^2, 2) ) ) < tor
		disp('***** Convergence reached... *****');
		break;
	end
	
	olddata = data;		% Update old data
end

reqtime = toc;			% 所要時間 [sec]


%% Show summary
fprintf('Took %.3f [sec] & %d iterations to convergence...\n', ...
	reqtime, nite);


%% Show result
plot(initdata(:,1), initdata(:,2), 'o', 'MarkerSize', 4, ...
	'Color', [0.9, 0.1, 0.2]);
hold on;

quiver(initdata(:,1), initdata(:,2), ...
	data(:,1) - initdata(:,1), data(:,2) - initdata(:,2), 0, ...
	'Color', [0.7 0.7 0.7]);

plot(data(:,1), data(:,2), 'o', 'MarkerSize', 4, ...
	'Color', [0.1, 0.2, 0.9], 'MarkerFaceColor', [0.1, 0.2, 0.7]);

daspect([1 1 1]);
title(sprintf('Num. of Iteration = %d', nite));

hold off;
