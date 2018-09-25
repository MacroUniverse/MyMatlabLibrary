% add noise
function y = addnoise(y, ratio)
y = y + 2*(rand(size(y))-0.5).*abs(y)*ratio;
end