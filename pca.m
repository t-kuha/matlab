


function [pcomp, coef, contrib, rdata] = pca(data, nComp)
zscore = (data - repmat(mean(data), size(data, 1), 1)) ...
	./ repmat(std(data), size(data, 1), 1);

[coef, D] = eig(cov(zscore));
pcomp = zscore*coef;	% å¬•ª

% Recoverd data (up to first nComp components)
rdata = pcomp(:, end-nComp+1:end)*(coef(:, end-nComp+1:end)');
rdata = rdata.*repmat(std(data), size(data, 1), 1)...
	+ repmat(mean(data), size(data, 1), 1);

contrib = cumsum(flipud(diag(D)/sum(D(:))));