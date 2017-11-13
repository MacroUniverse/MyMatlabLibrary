%Find the roots using bisection method in many small intervals
%fun is the function to be found 0
%interval is the total interval to find roots
%resolution is the number of intervals to use bisection

function roots = fzeroN(fun,interval,resolution)

x=linspace(interval(1),interval(end), resolution);
y=arrayfun(fun,x);
figure; plot(x,y,'+-')
title('the function to be found zeros of')
Sign=sign(y);
ind=find(Sign(1:end-1).*Sign(2:end)<0);

roots=zeros(size(ind));
for ii=1:numel(ind)
    roots(ii)=fzero(fun,[x(ind(ii)),x(ind(ii)+1)]);  
end
end