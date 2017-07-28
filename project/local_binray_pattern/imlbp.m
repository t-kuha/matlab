%% Local Binary Patterns

function lbp = imlbp(img)
%% Processing
lbp = zeros(size(img));

% lbpfun = @(x) bp_*reshape((x - x(5)) >= 0, numel(x), 1);
fun_ = @(x) lbpfun(x);

for ch = 1:size(img,3)
% 	lbp(:,:,ch) = nlfilter(img(:,:,ch), [3, 3], lbpfun);
	lbp(:,:,ch) = colfilt(img(:,:,ch), [3 3], 'sliding', fun_);
end



