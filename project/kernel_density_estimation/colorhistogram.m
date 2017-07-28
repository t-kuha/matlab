%% Color Histogram
% Plots color histogram
%

% rgb: RGB data ([0 1], double)
% h: Handle graphics 
% 

%%
function h = colorhistogram(rgb)

% Check input - 3-ch image or Nx3 matrix
assert( (ndims(rgb) == 3) || ( ismatrix(rgb) && (size(rgb,2) == 3) ), ...
	'Invalid input...');

% Convert to Nx3 matrix
if ndims(rgb) == 3
	rgb = reshape4colorconv(rgb);
end

rgb = unique(rgb, 'rows');	% 重複分のデータ量削減
% rgb = im2double(rgb);

h = scatter3(rgb(:,1), rgb(:,2), rgb(:,3), ones(size(rgb,1),1), rgb, '.');
daspect([1 1 1]);
xlabel('Red');	ylabel('Green');	zlabel('Blue');
xlim([0 1]);	ylim([0 1]);		zlim([0 1]);