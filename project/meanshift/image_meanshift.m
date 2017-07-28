%% 3-D meanshift

%%
ccc;

%% Setting
imgname = '.\sample_images\mean_shift_image.jpg';
bw = 20/255;
tor = 0.0003;		% Torelance

% Standard normal distribution
norm_dist = @(x, sigma) ...
	exp(-0.5*sum(x.^2, 2)/(sigma.^2)) / (sqrt(2*pi)*sigma);

%% Load image
img = im2double(imread(imgname));
img = imresize(img, 0.125);		% 大きすぎるので...
rgb = reshape4colorconv(img);

% imshow(img);
colorhistogram(rgb);			% Show Color Histogram

%% Start processing
rgb_tmp = rgb;				% 一時記憶
rgb_new = zeros(size(rgb));	% Shift後のデータ
needrenew = true(size(rgb,1),1);

for ite = 1:70

% 	tic;
	for p = 1:size(rgb,1)
		
		% 事前に不要なものをカット
		if needrenew(p) == false
			continue;
		end
		
		w = norm_dist(bsxfun(@minus, rgb, rgb_tmp(p,:)), bw);
		rgb_new(p,:) = sum(repmat(w,1,size(rgb,2)).*rgb)/sum(w);
		
		if sqrt(max(sum( (rgb_new(p,:) - rgb_tmp(p,:)).^2, 2 ) ) ) < tor
			needrenew(p) = false;
		end
	end
	
	% Globalでの終了条件
	fprintf('Max. Error = %f\n', ...
		sqrt(max(sum( (rgb_new - rgb_tmp).^2, 2 ) )));
	if sqrt(max(sum( (rgb_new - rgb_tmp).^2, 2 ) ) ) < tor
		disp('***** Convergence reached... *****');
		break;
	end

	rgb_tmp = rgb_new;
	rgb_old = rgb_new;
	
	colorhistogram(rgb_new);
	drawnow;
end

%% Group points
rgb_grp = unique(round(rgb_new, 2), 'rows');

%% Plot result
scatter3(rgb_grp(:,1), rgb_grp(:,2), rgb_grp(:,3), ...
	ones(size(rgb_grp,1),1)*20, rgb_grp, 'filled');
daspect([1 1 1]);
xlabel('Red');	ylabel('Green');	zlabel('Blue');
xlim([0 1]);	ylim([0 1]);		zlim([0 1]);

hold off;

%% Recover image
figure;
img_new = reshape(rgb_new, size(img));
imshow(img_new);
imwrite(img_new, 'tmp.tif');
