% plot circles in 3D
% 'R' (optional) is the radius (can be an array)
% 'N' (optional) is the number of points
% 'z' (optional) is the z axis coordinate

%% THIS FUNCTION IS NOT DONE!
function plotcircle(R, N, c, v, varargin)
if ~exist('R','var') || isempty(R)
   R = 1;
end
if ~exist('N','var') || isempty(N)
   N = 100; 
end
if ~exist('c','var') || isempty(c)
   c = [0,0,0];
end
if ~exist('v','var') || isempty(v)
   v = [0,0,1];
end
th = linspace(0, 2*pi, N);
X = R(:).*cos(th);
Y = R(:).*sin(th);
Z = zeros(size(X));
[X,Y,Z] = vturn(X,Y,Z,[0,0,1],v);
X=X+c(1); Y=Y+c(2); Z=Z+c(3);
plot3(X', Y', Z', varargin{:});
end
