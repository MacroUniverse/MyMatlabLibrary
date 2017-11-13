% Gaussian-Lobatto Quandrature
% Not accurate due to numerical root finding of Legendre Polynomial

function I = quadGL0(fun, N, a, b)
warning('This function is for study, not accurate, use quadGL1 instead');
if ~( exist('a','var') && exist('b','var') )
    a = -1; b = 1;
end
PL = legendreP(N-1);
PLder = polyder(PL); 
xi = roots(PLder); xi = sort(xi);

% improve the accuracy of root finding with bisection
for ii = 1:N-2
%     disp(ii);
%     disp(polyval(PLder,xi(ii)));
    set = optimset('TolX',1e-16);
    xi(ii) = fzero(@(x) polyval(PLder,x),[xi(ii)-1e-7,xi(ii)+1e-7],set);
%     disp(polyval(PLder,xi(ii)));
end
PLxi = polyval(PL,xi);

% %plot legendre polynomial of order N-1
% x = linspace(-1,1,200);
% figure; plot(x, polyval(PL,x)); hold on;  plot(x, polyval(PLder,x)); axis([-1,1,-2,2]);
% xlabel('x'); ylabel(['P_' num2str(N-1)])
% scatter(xi,PLxi); title([ num2str(N-1) 'th order Legendre Polynomial and the extremums']);

% there are N-2 xi as zeros of PLder
wi = 2./(N*(N-1)*PLxi.^2);

% % Testing Polynomial
% integrand polynomial
% integrandP = [ 3  0  1  0  8  0  5];
% evaluation of polynomial
% fx = polyval(integrandP,x);
% plot(x,fx);
% fxi = polyval(integrandP,xi);  f1 = sum(integrandP);
% scatter(xi,fxi);

ui = ((b-a)*xi+(b+a))/2;  % map range [a,b] to [-1,1]
I = 2/(N*(N-1))*(fun(a)+fun(b)) + wi' * fun(ui);
I = I/2*(b-a); % change range back

% analytical_ans = 1742/105;
% disp([I,analytical_ans])                 

end