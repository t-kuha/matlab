% �F�Č��� or �F����\���ʃt�@�C����� & �ǂݍ���

% 2011/4/2
% 

function dstData = getColorValues(path)
% Open file
fin = fopen(path);

% Read 1st line
strL = textscan(fin, '%s', 1, 'delimiter', '\n');
line = char(strL{1});

% Determine source type
if(strcmp(line(1:5), 'color'))
    %% �F�Č�
    % Read data
	data = textscan(fin, ...
        '%d %d %d %d %d %f %f %f %f %f %f %f %f %f %f %f %f %f', ...
		'delimiter', ',');
	
	% Set L*a*b* data
	dstData = [data{12} data{13} data{14}];
    
elseif(strcmp(line(1:5), 'Kanae'))
	%% Vesion 2.0.0
	textscan(fin, '%s', 5, 'delimiter', '\n')
	% 'treatAsEmpty', 'NA' ���|�C���g
	data = textscan(fin, ...
	   '%d %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', ...
	   24, 'treatAsEmpty', 'NA', 'delimiter', ',');
	dstData = [data{11} data{12} data{13}];
	
elseif(strcmp(line(1:12), '"ImageSizeX"'))
	%% �F����\
	% Skip 2 lines
	textscan(fin, '%s', 2, 'delimiter', '\n');
	
	% Do the same thing
	data = textscan(fin, ...
        '%d %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f %f', ...
		'delimiter', ',');
	dstData = [data{9} data{10} data{11}];	
end

fclose(fin);