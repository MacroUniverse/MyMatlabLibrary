% 数值二阶偏导 (变精度)
% D^2 f / D(x_i)D(x_j)
% 精确到最后一位有效数字
function ret = D2_ij_vpa(f, i, j, x, h)
[ret, digi] = D2_ij(f, i, j, x, h);
if digi >= 15
    return;
end
old_digi = digits;
digits(2*15.6536 - digi - 8);
ret = D2_ij(f, i, j, arrayfun(@num2vpa, x), h);
ret = double(ret);
digits(old_digi);
end
