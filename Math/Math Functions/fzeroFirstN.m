%Find the first N roots using bisection method in many small intervals
%fun is the function to be found 0
%interval is the total interval to find roots
%resolution is the number of intervals to use bisection

function roots = fzeroFirstN(fun,interval,resolution, N)

x=linspace(interval(1),interval(end), resolution);

ind = nan(N); kk = 1;
last_sign = sign(fun(x(1)));
for ii = 2:resolution
    sign_ii = sign(fun(x(ii)));
    if sign_ii * last_sign < 0
        ind(kk) = ii - 1; kk = kk + 1;
        if kk > N, break; end
    end
    last_sign = sign_ii;
end
if kk <= N, warning('Fewer than N roots found'); ind = ind(1:kk-1); end
%figure; plot(x(1:ii),y(1:ii),'+-')
% title('the function to be find zeros of')

roots=zeros(kk-1,1);
for ii=1:kk-1
    roots(ii)=fzero(fun,[x(ind(ii)),x(ind(ii)+1)]);  
end
end