% numerical indefinite integral
% this is only a simple implementation for more accurate one, inverse
% gradient() function.
function Y = Int(x, y)
N = numel(x);
Y = zeros(size(y));
Y(1) = 0;
for ii = 1:N-1
    Y(ii+1) = Y(ii) + y(ii)*(x(ii+1)-x(ii));
end
end