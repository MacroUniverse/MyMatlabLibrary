%Find the roots using bisection method in many small intervals
%fun is the function to be found 0
%interval is the total interval to find roots
%resolution is the number of intervals to use bisection
% if abs(fun(root)) < CvgTol, it's considered a converge root

function roots = fzeroN(fun,interval,resolution,CvgTol)
if ~exist('CvgTol','var') || isempty(CvgTol)
    CvgTol = inf; 
end

x=linspace(interval(1),interval(end), resolution);
y=arrayfun(fun,x);
figure; plot(x,y,'.-'); hold on;
title('the function to be found zeros of');
Sign=sign(y);
ind=find(Sign(1:end-1).*Sign(2:end)<0);

roots=zeros(size(ind)); kk = 0;
for ii=1:numel(ind)
    plot([x(ind(ii)),x(ind(ii)+1)], [fun(x(ind(ii))),fun(x(ind(ii)+1))], '.-r');
    [root, val] = fzero(fun,[x(ind(ii)),x(ind(ii)+1)]);
    if abs(val) < CvgTol
        kk = kk + 1;
        roots(kk) = root;
        scatter(root, fun(root));
    end
end
roots = roots(1:kk);
end
