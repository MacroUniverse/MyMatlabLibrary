% same as oulomb1_mex(), with testing
% sampling test "coulomb_mex" results every 'step' elements with "coulomb1"
% 'step' is 10 by default

function F = coulomb1_mex_tested(l,k,r,Z,step)
abs_tol = 1e-9; % set error tolerence
if ~exist('Z','var') || isempty(Z), Z = -1; end
if ~exist('step','var') || isempty(step), step = 10; end
F = coulomb1_mex(l,k,r,Z);
ind = numel(r):-step:1;
F1 = coulomb1(l,k,r(ind),Z);
err = max(abs(F(ind)-F1));
if err > abs_tol
    warning(['coulomb1_mex() abs error = ', num2str(err), ' > ', num2str(abs_tol)]);
end
end
