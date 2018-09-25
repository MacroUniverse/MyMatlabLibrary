% Matrix for fft interpolation
% size(M) = [N1,N];
% this code is not optimal (sifftsmat(N1) left and right columns are not used)
function M = fftinterpmat(N1, N)
M = sifftsmat(N1)*fftresize(sfftsmat(N),N1)*N1/N;
end
