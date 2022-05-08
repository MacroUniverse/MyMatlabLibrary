% 精确解出 x = N*2^Npow， 其中 N 是奇数和整数, Npow 是整数
function [N, Npow] = num2bin2(x)
if isnan(x) || isinf(x)
    N = x; Npow = x; return;
end
N = x;
Npow = 0;
for e = [16, 8, 4, 2, 1]
    fac = 2^e;
    while true
        if mod(N, 1) == 0
            break;
        end
        N = N * fac;
        Npow = Npow - e;
    end
    while true
        if mod(N, fac) == 0
            N = N / fac;
            Npow = Npow + e;
        else
            break;
        end
    end
end
end
