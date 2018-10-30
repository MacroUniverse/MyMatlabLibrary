% numerical indefinite integral
% (Y(ii+1)-Y(ii))/(x(ii+1)-x(ii)) = (y(ii+1)+y(ii))/2
% (Y(ii+1)-Y(ii-1))/(x(ii+1)-x(ii-1)) = 0.5*y(ii-1)*(x2-x1)/(x3-x1) +
%                                       0.5*y2 + 0.5*y3*(x3-x2)/(x3-x1)
function Y = Int(x, y)
error('use cumsum() instead');
end
