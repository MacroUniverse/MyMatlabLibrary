function fftplot(dx, y, varargin)
N = numel(y);
x = fftlinspace(dx*N, N);
plot(x, y, varargin{:});
end