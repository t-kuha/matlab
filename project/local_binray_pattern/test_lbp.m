%% LBP test

ccc;

%% Setting & load image
imgpath = 'peppers.png';
img = im2double(imread(imgpath));

% imshow(img);
fprintf('Image Size: %d x %d\n', size(img,1), size(img,2));

img = imgaussfilt(img, 1);

%% Processing
tic;
img_lbp = imlbp(img);
toc;

% Show result
figure(2);
imshow(img_lbp);

 
%{
img_lbp2 = zeros(size(img));

bp = 2.^[7 6 5; 0 0 4; 1 2 3]/255;
bp(2,2) = 0;

% ‚»‚Ì1
tic;

for ch = 1:size(img,3)
for c = 1+1:size(img,2)-1
	for r = 1+1:size(img,1)-1
		tmp = ((img(r-1:r+1, c-1:c+1, ch) - img(r, c, ch)) >= 0).*bp;
		img_lbp2(r,c,ch) = sum(tmp(:));
% 		img_lbp(r,c,ch) = lbpfun(reshape(img(r-1:r+1, c-1:c+1, ch), 9, 1));
	end
end
end

toc;

figure(1);
subplot(1, 2, 1);	imshow(img);
subplot(1, 2, 2);	imshow(img_lbp2);
%}
