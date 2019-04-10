% the error function for matching two functions y1(x) and y2(x) at x0.
% err = 0 when y1(x0) = y2(x0) and derivatives dy1(x0) = dy2(x0)
% robust algorith: let y(x) = sin(th-x0), th in [0, pi], compare th1 and th2

function [err, th1, th2] = fmatch_err(y1,dy1,y2,dy2)
th1 = atan2(y1,dy1);
th2 = atan2(y2,dy2);
err = mod(th2 - th1, 2*pi);
if err > 0.5*pi && err <= 1.5*pi
    err = pi - err;
elseif err > 1.5*pi
    err = -2*pi + err;
end
end
