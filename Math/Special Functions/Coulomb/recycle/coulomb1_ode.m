% calculate coulomb radial wave function by solving ODE and interpolate
% 'l','k' must be scalars
% Initial point of ode is 'mean(min(r),max(r))', calculated with
% 'coulomb1()' and 'dcoulomb1()'
% efficiency of 'coulomb1()' for 2000 elements is "0.0042s/element" on
% surface
% this function is about 20 times faster, with about 4 digits precision

function F = coulomb1_ode(l,k,r)
warning('this code is bad, use "coulomb1()" or "coulomb_mex()" instead');
Z = 1; eta2 = -2*(Z/k); llp1 = l*(l+1);
if any(r < 0), error('r must be >= 0 !'); end
rmin = min(r(:)); rmax = max(r(:));
r0 = 0.5*(rmin + rmax);

% initial condition
y0 = [coulomb1(l,k,r0); dcoulomb1(l,k,r0)/k];
f = @(t,y) fun(t,y,llp1,eta2);
[t1,y1] = ode45(f,[k*r0,k*rmin],y0);
[t2,y2] = ode45(f,[k*r0,k*rmax],y0);
t = [fliplr(t1(2:end).'), t2.'];
y = [fliplr(y1(2:end,1).'), y2(:,1).'];
ind = find(isnan(y)); ind = ind(end);
t(1:ind) = []; y(1:ind) = [];
kr = k*r;
mark = kr > t(1);
F(mark) = spline(t,y,kr(mark));
F(~mark) = coulomb1(l,k,r(~mark));
end

% coulomb differential equation
function dydt = fun(t, y, llp1, eta2)
dydt(2,1) = (llp1/(t*t) + eta2/t - 1)*y(1);
dydt(1) = y(2);
end
