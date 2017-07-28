% sample L*a*b* data generation

%%
ccc;

%% Generate data in L*a*b* space
% tic;
prec = 10;
L = 0:prec:100;
a = -100:prec:100;
b = -100:prec:100;
[LL, aa, bb] = ndgrid(L, a, b);

num = numel(LL);
LL = reshape(LL, num, 1);
aa = reshape(aa, num, 1);
bb = reshape(bb, num, 1);

data = [LL aa bb];
% toc;

% L*a*b* -> sRGB
ctfrm = makecform('lab2srgb');
% tic;
rgb = applycform(data, ctfrm);
% toc;

% Too slow! 
% n = length(data);
% rgb2 = zeros(n,3);
% tic;
% for ii = 1:n
% 	rgb2(ii,:) = applycform(data(ii,:), ctfrm);
% end
% toc;

%% RGB ver

