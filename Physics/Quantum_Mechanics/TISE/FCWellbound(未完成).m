% finite circular well bound state
% matching method

function FCWellbound(l,V0)
resolution = 20;

% spherical bessel functions and derivatives
j = @(l,x)sqrt(pi./(2*x)).*besselj(l+0.5,x);

% the non-classical region's solution is the first hankel function!
k = @(l,x)sqrt(pi./(2*x)).*besselh(l+0.5,x);
kd = @(l,x) h(l-1,x)-(l+1)./x.*h(l,x);

E = fzeroN(@(E)trial(E,V0,l,j,jd),[V0+eps,0],resolution);

% plot
for ii = 1:numel(E)
    [~,V] = trial(E(ii),V0,l,j,jd);
    r = linspace(0,8,200); R = zeros(size(r));
    mark = r<1;
    k0 = sqrt(2*(E(ii)-V0));
    k = sqrt(-2*E(ii));
    R(mark) = j(l,k0*r(mark));
    R(~mark) = V(1)*exp(k*r(~mark)) + V(2)*exp(-k*r(~mark));
    figure; plot(r,R);
end
end


function [out,V] = trial(E,V0,l,j,jd)
k0 = sqrt(2*(E-V0));
k = sqrt(-2*E);
Ep = exp(k0); Em = exp(-k0);
% The matrix is so wronng! r>1 is not exp function!
Mat = [Ep,Em; Ep,-Em]; b = [j(l,k0); k0*jd(l,k0)/k];
V = Kramer2(Mat,b);
out = V(1);
end

% Using Kramer's rule to solve 2*2 linear system;
% No singularity checking

function V = Kramer2(Mat,b)
InvDet = 1/det(Mat);
V = [0;0];
V(1) = (b(1)*Mat(2,2)-b(2)*Mat(1,2))*InvDet;
V(2) = (Mat(1,1)*b(2)-Mat(2,1)*b(1))*InvDet;
end

%Find the roots using bisection method in many small intervals
%fun is the function to be found 0
%interval is the total interval to find roots
%resolution is the number of intervals to use bisection

function roots = fzeroN(fun,interval,resolution)

x=linspace(interval(1),interval(end), resolution);
y=arrayfun(fun,x);
figure; plot(x,y,'+-')
title('the function to be found zeros of')
Sign=sign(y);
ind=find(Sign(1:end-1).*Sign(2:end)<0);

roots=zeros(size(ind));
for ii=1:numel(ind)
    roots(ii)=fzero(fun,[x(ind(ii)),x(ind(ii)+1)]);  
end
end