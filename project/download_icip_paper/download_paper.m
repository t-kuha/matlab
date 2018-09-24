%% 
cnt = 848;

load('papre_list.mat');

%% Download
options = weboptions;
options.Timeout = 300; 

for n = 1:cnt-1
     url = sprintf(...
         'http://ieeexplore.ieee.org/stampPDF/getPDF.jsp?%s', ar_list{n});
     
     websave(sprintf('%s.pdf', ar_list{n}(10:end)), url, options);
end
