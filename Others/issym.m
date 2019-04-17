% check if is symbolic variable
% support any number of arguments
function out = issym(varargin)
N = numel(varargin);
out = true(1,N);
for i = 1:N
    out(i) = isa(varargin{i}, 'sym');
end
end
