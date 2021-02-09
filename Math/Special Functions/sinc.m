function y = sinc(x)
mark = (x ~= 0);
y = sin(x(mark))./x(mark);
y(~mark) = 1;
y = reshape(y, size(x));
end
