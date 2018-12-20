% the inverse of 'encode'

function str = decode(str)
a = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
b = '1234567890bcdefghijklmnopqrstuvwxyzaBCDEFGHIJKLMNOPQRSTUVWXYZA';
N = numel(a);
for ii = 1:numel(str)
    for jj = 1:N
        if str(ii) == b(jj)
            str(ii) = a(jj); break;
        end
    end
end
end