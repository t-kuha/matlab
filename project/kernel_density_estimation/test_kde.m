% Kernel Density Estimation

ccc;

%%
h = 0.1;		% Band width
N = 100;		% Num. of data
datanum = 200;	% Grid size

% Standard normal distribution
norm_dist = @(x) exp(-x.*x/2)/sqrt(2*pi);

% Input data
data = randn(N,1);

% Optimal h
% h = 1.06*std(data)*N^(-1/5);

x = linspace(min(data)-1, max(data)+1, datanum);

x2 = (repmat(x,N,1) - repmat(data,1,datanum))/h;
y2 = norm_dist(x2);

y = mean(y2)/(h);

% y3 = mvnpdf(x', data(1), h);


%% 
figure;
hold on;

% Plot individual line
for k = 1:N
	hnd = plot(x, y2(k,:), '-', 'color', [0.5, 0.5, 0.5]); 
	hnd.Color(4) = 0.2;		% Set line transparency
end

plot(data, zeros(size(data)), 'o', 'Color', [0.9, 0.1, 0.2]);    % Original data
plot(x, y, 'color', [0.2, 0.2, 0.2]);   % Estimate

hold off;

%% Check
% ‚±‚ê‚ª1‚É‹ß‚­‚È‚Á‚Ä‚¢‚é‚±‚Æ
disp((max(data) - min(data) + 2)/datanum*sum(y));

