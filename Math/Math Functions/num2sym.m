% 双精度转换为符号表达式
% sym(x) 会对 x 进行猜测和近似，该函数不会
function s = num2sym(x)
[N, Npow] = num2bin2(x);
s = sym(N)*2^sym(Npow);
end
