%% Color Plotter (ver. 1.0)
% 
% 
% 

function varargout = ColorPlotter(varargin)
% COLORPLOTTER MATLAB code for ColorPlotter.fig
%      COLORPLOTTER, by itself, creates a new COLORPLOTTER or raises the existing
%      singleton*.
%
%      H = COLORPLOTTER returns the handle to a new COLORPLOTTER or the handle to
%      the existing singleton*.
%
%      COLORPLOTTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COLORPLOTTER.M with the given input arguments.
%
%      COLORPLOTTER('Property','Value',...) creates a new COLORPLOTTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ColorPlotter_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ColorPlotter_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ColorPlotter

% Last Modified by GUIDE v2.5 17-Nov-2011 09:23:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ColorPlotter_OpeningFcn, ...
                   'gui_OutputFcn',  @ColorPlotter_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before ColorPlotter is made visible.
function ColorPlotter_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ColorPlotter (see VARARGIN)

% Choose default command line output for ColorPlotter
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ColorPlotter wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% Do not show axes
set(handles.axesGraph, 'xcolor', get(gcf, 'Color'));
set(handles.axesGraph, 'xtick', []);
set(handles.axesGraph, 'ycolor', get(gcf, 'Color'));
set(handles.axesGraph, 'ytick', []);

handles.measData = [];
handles.refData = [];

guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ColorPlotter_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Measured data file edit box
function editMeas_Callback(hObject, eventdata, handles)
handles.dataMeasFile = get(hObject, 'String');
guidata(hObject, handles);

function editMeas_CreateFcn(hObject, eventdata, handles) %#ok
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Measured data file button
function pushMeas_Callback(hObject, eventdata, handles)
% % Read file (.csv or .txt)
% [fName, path, fIdx] = uigetfile(...
% 	{'*.csv', 'CSV File (*.csv)';...
% 	'*.txt', 'TEXT File (*.txt)';...
% 	'*.mat', 'MATLAB Data File, (*.mat)'},...
% 	'Select a Measurement Data File...');
% 
% if(fName ~= 0)
% 	% If file is selected...
% 	set(handles.editMeas, 'String', fName);
% 	%guidata(hObject, handles);
% 	
% 	% Load data & show graph
% 	if(fIdx == 3)
% 		% MATLAB Data File
% 		tmpdata = load([path fName]);
% 		measData = tmpdata.data;
% 		measData = measData(:,1:3);
% 	else
% 		% .csv or .txt file
% 		measData = readKanaeData([path fName]);
% 	end
% 
% 	% Set data
% 	handles.measData = measData;
% 	set(handles.tableData, 'Data', measData);
% 	set(handles.tableData, 'ColumnWidth', {60});
% 	
% % 	set(handles.popupData, 'Value', 1);
% 	guidata(hObject, handles);
% 	% Show graph
% 	
% 	plotLab3D(handles.axesGraph, measData, handles.refData);
% end
setColorData(handles);


%% Reference file
function editRef_Callback(hObject, eventdata, handles)
handles.dataRefFile = get(hObject, 'String');
guidata(hObject, handles);

function editRef_CreateFcn(hObject, eventdata, handles) %#ok
if ispc && isequal(get(hObject,'BackgroundColor'), ...
		get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Reference file button
function pushRef_Callback(hObject, eventdata, handles)
% % Read file
% [fName, path, fIdx] = uigetfile(...
% 	{'*.csv', 'CSV File (*.csv)';...
% 	'*.txt', 'TEXT File (*.txt)';...
% 	'*.mat', 'MATLAB Data File (*.mat)'},...
% 	'Select a Reference Data File...');
% 
% if(fName ~= 0)
% 	set(handles.editRef, 'String', fName);
% 	guidata(hObject, handles);
% 	
% 	if(fIdx == 3)
% 		% MATLAB Data File
% 		tmpdata = load([path fName]);
% 		refData = tmpdata.data;
% 		refData = refData(:,1:3);
% 	else
% 		% .csv or .txt file
% 		refData = readKanaeData([path fName]);
% 	end
% 	
% 	% Load data & show graph
% 	handles.refData = refData;
% 	set(handles.tableData, 'Data', refData);
% 	set(handles.tableData, 'ColumnWidth', {60});
% % 	set(handles.popupData, 'Value', 2);
% 	guidata(hObject, handles);
% 	plotLab3D(handles.axesGraph, handles.measData, refData);
% end
setColorData(handles);

%% Save figure
function uipushSave_ClickedCallback(hObject, eventdata, handles)

set(gcf, 'PaperPositionMode', 'auto');

% Show "Save File" dialog
filter = {	'*.fig', 'MATLAB Figure (*.fig)'; ...
				'*.eps', 'EPS File (*.eps)'; ...
				'*.bmp', 'Bitmap File (*.bmp)'; ...
				'*.tif', 'TIFF File (*.tif)'; ...
				'*.jpg', 'JPEG File (*.jpg)'; ...
				'*.pdf', 'PDF File (*.pdf)'};
[fName, path, fIdx] = uiputfile(filter, 'Save Figure As...');
ext = filter{fIdx, 1};
ext = regexprep(ext, '*.', '');

if(strcmp(ext, 'eps'))
% 	Color post script
	ext = 'psc2';
end

% Cpy plot to separate invisible figure & save it 
tmpFig = figure(10);
set(tmpFig, 'Visible', 'off');
copyobj(handles.axesGraph, tmpFig);
saveas(tmpFig, [path fName], ext);
close(tmpFig);


%% Data drop-dwon list
function popupData_Callback(hObject, eventdata, handles)

% Data to be displayed
% 1: Measured data
% 2: Reference data
% 3: Difference ()
dataType = get(hObject, 'Value');	

switch(dataType)
	case 1
		% Measured data
		if(isempty(handles.measData) == 0)
			% If data exists...
			set(handles.tableData, 'Data', handles.measData);
		else
			% If there is no data, display " - - - "
			set(handles.tableData, 'Data', cellstr(['-'; '-'; '-'])');				
		end
		
	case 2
		% Reference data
		if(isempty(handles.refData) == 0)
			set(handles.tableData, 'Data', handles.refData);	
		else
			set(handles.tableData, 'Data', cellstr(['-'; '-'; '-'])');	
		end
		
	case 3
		% Check data size
		[mh, mw, ~] = size(handles.measData);
		[rh, rw, ~] = size(handles.refData);
		if( (mh > 0) && (mw > 0) && (rh > 0) && (rw > 0) ...
				&& (mh == rh) && (mw == rw) )
			set(handles.tableData, 'Data', handles. measData - handles.refData);
		else
			set(handles.tableData, 'Data', cellstr(['-'; '-'; '-'])');			
		end
		
	otherwise
		% DO NOTHING
		return;
end

set(handles.tableData, 'ColumnWidth', {60});
guidata(hObject, handles);

function popupData_CreateFcn(hObject, eventdata, handles) %#ok

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
