% replace 0-9 with 1,2,3...9,0
% replace a-z with b,c,d...z,a
% replace A-Z with B,C,D...Z,A

function str = encode(str)
a = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
b = '1234567890bcdefghijklmnopqrstuvwxyzaBCDEFGHIJKLMNOPQRSTUVWXYZA';
N = numel(a);
for ii = 1:numel(str)
    for jj = 1:N
        if str(ii) == a(jj)
            str(ii) = b(jj); break;
        end
    end
end
end
