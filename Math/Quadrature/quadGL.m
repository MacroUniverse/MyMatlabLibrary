% Gauss-Lobatto Quadrature
% N is the # of sample points including end points x = a, b

function I = quadGL(fun, N, a, b)
if ~( exist('a','var') && exist('b','var') )
    a = -1; b = 1;
end
[xi,wi]=GaussLobattoData(N);
ui = ((b-a)*xi+(b+a))/2;
I = dot(wi,fun(ui));
I = I/2*(b-a);
end