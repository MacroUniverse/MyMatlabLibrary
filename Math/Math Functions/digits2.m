% 求当前 vpa 变精度计算的有效数字
% digi_dec 是十进制有效数字
% digi_bin 是二进制有效数字
% eps 是最大相对精度
function [digi_dec, digi_bin, eps] = digits2
n = 0;
while true
    n = n + 1;
    if (1 + 2^(-vpa(n))) - 1 == 0
        break;
    end
end
digi_dec = n * log10(2) + 1;
digi_bin = n + 1;
eps = 2^(-n);
end
