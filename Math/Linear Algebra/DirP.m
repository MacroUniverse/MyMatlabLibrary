% calculate the direct product of two vectors

function M = DirP(M1,M2)
[Nr1,Nc1] = size(M1); [Nr2,Nc2] = size(M2);
M = zeros(Nr1*Nr2, Nc1*Nc2);
for ii = 1:Nr1
for jj = 1:Nc1
    M(Nr2*(ii-1)+1:Nr2*ii,Nc2*(jj-1)+1:Nc2*jj) = M1(ii,jj)*M2;
end
end
end





