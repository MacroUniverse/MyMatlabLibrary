%Lagrange Polynomial Basis
% plotflag is optional, when exist, will plot the function
function fn = LagrangeInterpBasis(x,xn,n,plotflag)
N = numel(xn);
fn = 1;
for ii = [1:n-1 n+1:N]
    fn = fn.*(x-xn(ii))/(xn(n)-xn(ii));
end
if exist('plotflag','var')
    plotflag = plotflag*0;
    plot(x,fn); hold on; axis([xn(1),xn(end),-3,3+plotflag]);
    val = zeros(size(xn)); val(n) = 1;
    scatter(xn,val)
end
end