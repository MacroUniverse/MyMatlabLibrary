% 数值偏导 (变精度)
% f 需要支持 sym 类型的变精度参数
% 精确到最后一位有效数字
function ret = D_i_vpa(f, i, x, h)
[ret, digi] = D_i(f, i, x, h);
if digi >= 15
    return;
end
old_digi = digits;
digits(2*15.6536 - digi - 8);
ret = D_i(f, i, num2vpa(x), h);
ret = double(ret);
digits(old_digi);
end
