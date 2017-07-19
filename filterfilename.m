%% filterfilename
% 指定されたフォルダー内のファイルのうち，指定された形式のファイルのパスを返す
% 
%  Input:  srcdir:   Source directory (as 'char' or 'cell string')
%          fileext:  Extension
%          mode:     Output mode ('full' or 'name')
%  Output: namelist: Filtered name (as cell string)
%  
%  2013/02/05 - v. 1.0
%  2013/04/04 - v. 1.1

%% Function main
function namelist = filterfilename(srcdir, fileext)

% Check input type & size
assert(ischar(srcdir) || iscellstr(srcdir), ...
	'Input ''srcdir'' must be char array or cell string');

% Convert to char
if iscellstr(srcdir)
	srcdir = char(srcdir);
end

% Check size
if ~isrow(srcdir)
	warning('Specify only 1 directory...');
	namelist = [];
	return;
end


% Get all the file names in 'srcdir'
list = dir(srcdir);

% 有効な名前のみ抜き出し
namelist = cell(numel(list), 1);	% Store file names
namefilter = false(numel(list), 1);	% true if extension is valid

% loop使いたくないが...
for k = 1:numel(list)
	% Full path 作成
	namelist{k} = [srcdir filesep list(k).name];
	
	% 拡張子取り出し & 照合	
	[~, ~, ext] = fileparts(namelist{k});
	% '> 0'は'== 1' でもよい 
	if sum(strcmp(ext, fileext)) > 0
		namefilter(k) = true;
	end
end

namelist = namelist(namefilter);

