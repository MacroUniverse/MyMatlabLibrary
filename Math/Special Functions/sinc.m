function y = sinc(x)
y = zeros(size(x));
mark = (x ~= 0);
y = sin(x(mark))./x(mark);
y(~mark) = 1;
end
