% the error function for matching two functions y1(x) and y2(x) at x0.
% err = 0 when y1(x0) = y2(x0) and derivatives dy1(x0) = dy2(x0)
% robust algorith: let y(x) = sin(th-x0), th in [0, pi], compare th1 and th2

function err = fmatch_err(y1,dy1,y2,dy2)
th1 = mod(atan2(y1,dy1),pi);
th2 = mod(atan2(y2,dy2),pi);
err = th2 - th1;
if err >= pi/2
    err = pi - err;
elseif err < -pi/2
    err = -pi - err;
end
end
