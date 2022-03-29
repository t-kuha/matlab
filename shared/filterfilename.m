%% filterfilename
% filter out file path in the specified directory based on the extension
% 
%  input:  srcdir:   source directory ("char", "string")
%          fileext:  extension ("char", "string", "cell string")
%  output: pathlist: full paths (as cell string)

%% Function main
function pathlist = filterfilename(srcdir, fileext)

% check input
assert(ischar(srcdir) || isstring(srcdir), ...
	'''srcdir'' must be char array or string');
assert(ischar(fileext) || isstring(fileext) || iscellstr(fileext), ...
	'''fileext'' must be char array or string');

% get all the file names in 'srcdir'
list = dir(char(srcdir));

% filter out file names with the specified extension
pathlist = cell(numel(list), 1);	% file paths
is_valid = false(numel(list), 1);	% true if extension is valid

for k = 1:numel(list)
    % make full path
	pathlist{k} = fullfile(char(srcdir), list(k).name);	
	[~, ~, ext] = fileparts(pathlist{k});
	is_valid(k) = any(strcmp(ext, fileext));
end

pathlist = pathlist(is_valid);
