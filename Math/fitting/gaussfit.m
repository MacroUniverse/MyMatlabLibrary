% guass fitting by least square and minimum search
% fit the curve to y = A*exp(-(x-x0)^2/sigma^2) + y0;
% wave packet must be complete with >4 backgroud points on each side

function [x0,A,sigma,relErr] = gaussfit(x,y)
% initial parameters

N = numel(x);
y0 = 0.5*mean(y(1:5)+y(end-4:end));

[A,ind] = max(y); A = A - y0;
x0 = x(ind); sigma = 0.2*(x(end)-x(1));
ytrim = y - y0;
param0 = [x0,A,sigma];
param = fminsearch(@(param)trial(x,ytrim,param),param0);
x0 = param(1); A = param(2); sigma = param(3);
relErr = trial(x,y,param)/N;

% plot
figure; plot(x, A*exp(-(x-x0).^2/sigma^2)+y0); 
hold on; scatter(x,y); plot(x,y);
end

function S2 = trial(x,ytrim,param)
x0 = param(1); A = param(2); sigma = param(3);
S2 = sum((ytrim - A*exp(-((x-x0)./sigma).^2)).^2);
end