%%


%% 
function setColorData(handles)

% Read file (.csv or .txt)
[fName, path, fIdx] = uigetfile(...
	{'*.csv', 'CSV File (*.csv)';...
	'*.txt', 'TEXT File (*.txt)';...
	'*.mat', 'MATLAB Data File, (*.mat)'},...
	'Select a L*a*b* Data File...');

% If file is selected...
if(fName ~= 0)
	% Set file name
	set(handles.editMeas, 'String', fName);
	%guidata(hObject, handles);
	
	% Load data & show graph
	if(fIdx == 3)
		% MATLAB Data File
		tmpdata = load([path fName]);
		data = tmpdata.data;
		data = data(:,1:3);

	else
		% .csv or .txt file
		data = readKanaeData([path fName]);
	end

	% Set data
	handles.measData = data;
	set(handles.tableData, 'Data', data);
	set(handles.tableData, 'ColumnWidth', {60});
	
% 	set(handles.popupData, 'Value', 1);
	%guidata(hObject, handles);
	% Show graph
	
	plotLab3D(handles.axesGraph, data, handles.refData);
end