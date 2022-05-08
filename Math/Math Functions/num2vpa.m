% 双精度转换为变精度浮点数
% vpa(x) 会对 x 进行猜测和近似，该函数不会
function ret = num2vpa(x, digi)
if nargin == 1
    ret = vpa(num2sym(x));
elseif nargin == 2
    ret = vpa(num2sym(x), digi);
end
end
