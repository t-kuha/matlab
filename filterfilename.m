%% filterfilename
% �w�肳�ꂽ�t�H���_�[���̃t�@�C���̂����C�w�肳�ꂽ�`���̃t�@�C���̃p�X��Ԃ�
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

% �L���Ȗ��O�̂ݔ����o��
namelist = cell(numel(list), 1);	% Store file names
namefilter = false(numel(list), 1);	% true if extension is valid

% loop�g�������Ȃ���...
for k = 1:numel(list)
	% Full path �쐬
	namelist{k} = [srcdir filesep list(k).name];
	
	% �g���q���o�� & �ƍ�	
	[~, ~, ext] = fileparts(namelist{k});
	% '> 0'��'== 1' �ł��悢 
	if sum(strcmp(ext, fileext)) > 0
		namefilter(k) = true;
	end
end

namelist = namelist(namefilter);

