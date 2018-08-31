% [w,x1,x2,yHM,x0] = FWHM(x,y,~)
% simple FWHM calculation
% includes linear interpolation
% input the third argument to plot a line.

function [w,x1,x2,yHM,x0] = FWHM(x,y,~)
Nx = numel(x);
y = abs(y);
[ymax,ind0] = max(y); x0 = x(ind0);
yHM = ymax/2;
flag = [0,0];
for ii = ind0-1:-1:1
    if y(ii) < yHM
        x1 = (x(ii+1)-x(ii))/(y(ii+1)-y(ii))*(yHM-y(ii))+x(ii);
        flag(1) = 1;
        break;
    end
end
for ii = ind0+1:Nx
    if y(ii) < yHM
        x2 = (x(ii)-x(ii-1))/(y(ii)-y(ii-1))*(yHM-y(ii-1))+x(ii-1);
        flag(2) = 1;
        break;
    end
end
if flag(1)==0
    error('cannot find x1')
elseif flag(2)==0
    error('cannot find x2')
end
w = x2-x1;
if nargin == 3
    hold on; plot([x1,x2],[yHM,yHM]);
    text(x2+0.2*w, yHM, ['FWHM=',num2str(w)]);
end
end
