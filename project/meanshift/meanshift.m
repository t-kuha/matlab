%% meanshift algorithm

%% Clear workspace
ccc;


%% Load data
load('.\meanshift\data.mat');
initdata = [x1, x2];	% �����f�[�^ (plot�p�Ƃ��Ă��̂܂܎c��)
clear x1 x2;

% Standard normal distribution
norm_dist = @(x, sigma) ...
	exp(-0.5*sum(x.^2, 2)/(sigma.^2)) / (sqrt(2*pi)*sigma);

%% 
bw = 0.8;				% Band width
tor = 0.000001;			% �I������ (Tolerance)

data = initdata;		% �J��Ԃ����ɍX�V
olddata = data;			% �O��Ƃ̋����̌v�Z�Ɏg�p

nite = 0;				% Num. of iterations
maxite = 1000;

%% Processing
tic;

while(nite < maxite)
	nite = nite + 1;	% Counter
		
% 	% �r���o��
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
		% bw �ȓ��ɓ������_�𒊏o -> ���̕��ψʒu���v�Z
% 		idx = sum((initdata - repmat(tmp, size(data,1), 1)).^2, 2) <= bw;
% 		data(p,:) = mean(initdata(idx, :));		
	end
	
	if max( sqrt( sum((data - olddata).^2, 2) ) ) < tor
		disp('***** Convergence reached... *****');
		break;
	end
	
	olddata = data;		% Update old data
end

reqtime = toc;			% ���v���� [sec]


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
