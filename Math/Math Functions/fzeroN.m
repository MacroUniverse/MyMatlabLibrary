%Find the roots using bisection method in many small intervals
%fun is the function to be found 0
%interval is the total interval to find roots
%resolution is the number of intervals to use bisection

function roots = fzeroN(fun,interval,resolution,converge,options)
if ~exist('converge','var') || isempty(converge)
    converge = false;
end
if ~exist('options','var')
    options = optimset;
end
x=linspace(interval(1),interval(end), resolution);
y=arrayfun(fun,x);
figure; plot(x,y,'.-'); hold on;
title('the function to be found zeros of');
[Nind, ind] = numzero(y);

roots=zeros(1, Nind); kk = 0;
for ii=1:Nind
    plot([x(ind(ii)),x(ind(ii)+1)], ...
        [fun(x(ind(ii))),fun(x(ind(ii)+1))], '.-r');
    root = fzero(fun,[x(ind(ii)),x(ind(ii)+1)], options);
    if ~converge || converge && iszero(fun,root,options.TolX)
        kk = kk + 1;
        roots(kk) = root;
        scatter(root, fun(root), 'b');
    end
end
roots = roots(1:kk);
end
