% generate the transform matrix for sffts()
function M = fftmat(N)
M = zeros(N, N);
expo = exp(-1i*2*pi*(1:N-1)/N);
M(1,:) = 1; M(2:end,1) = 1;
for ii = 2:N
    M(ii,ii:end) = M(ii-1,ii:end).*expo(ii-1:end);
    M(ii+1:end,ii) = M(ii,ii+1:end);
end
end
