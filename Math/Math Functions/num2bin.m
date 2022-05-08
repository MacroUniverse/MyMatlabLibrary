% x = a*2^Npw (exactly)
% 1 <= a < 2， 精度为 digits2() 输出的 eps
% 若 x 是双精度， 则 a 的绝对精度为 2^(-52), 也就是 eps
% 若 x 是单精度， 则 a 的绝对精度为 2^(-23), 也就是 eps('single')
% 最小的双精度为 2^(-52)*2^(-1022)， 最大的双精度为 (2-eps)*2^1023
function [a, Npow] = num2bin(x)
if isnan(x) || isinf(x)
    a = x; Npow = x; return;
end
sgn = sign(x); x = abs(vpa(x));
Npow = floor(log2(x));
a = sgn * (x * 2^(-Npow));
if a*2^Npow - sgn*x ~= 0
    error('something wrong!');
end
end
