%% L*a*b* plot application


%% 
classdef appLabPlot < handle
	%appLabPlot Summary of this class goes here
	%   Detailed explanation goes here
	
	properties (SetAccess = private)
		% L*a*b* values
		measData;
		refData;
		
		% Figure
		Figure;
		Axis;
		figname = 'L*a*b* Plot';
		

		
		% Plot option
		drawline = false;
		plotcolor;
		
		Lrange;
		arange;
		brange;		
		
	end
	
	methods
		% Constructor
		function theApp = appLabPlot()
			theApp.measData = [];
			theApp.refData = [];
			
			theApp.Figure = figure('NumberTitle', 'off', ...
				'Name', theApp.figname);
			theApp.Axis = axes('Parent', theApp.Figure);
			
			set(get(theApp.Axis, 'XLabel'), 'String', 'a*');
			set(get(theApp.Axis, 'YLabel'), 'String', 'b*');
			set(get(theApp.Axis, 'ZLabel'), 'String', 'L*');
		end
		
% 		function closeApp(theApp, hObject, eventdata)
% 			delete(theApp.Figure)
% 		end
		
		% Setter/Getter
		function setMeasData(theApp, lab)
			theApp.measData = lab;
		end
		
		function setRefData(theApp, lab)
			theApp.refData = lab;
		end
		
		function lab = getMeasData(theApp)
			lab = theApp.measData;
		end
		
		function lab = getRefData(theApp)
			lab = theApp.refData;
		end
		
		% Plot
		function changefigname(theApp, name)
			set(theApp.mainfig, 'Name', name);
		end
		
		% Utility
		function startplot(theApp)
			cla(theApp.Figure);
			
			
		end
		
	end
	
	methods (Access = private)
	
		
	end
	
end

