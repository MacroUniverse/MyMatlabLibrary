% solve bound state energies of 1D potential
% shooting from both side, then match at some middle point
% varargin are options for ode45 solver
% Eng(i) is the bound state i energies
% psi(:,i) is the wave function of Eng(i)
% output Y = [psi(x); psi'(x)]
function [Eng, X, Psi] = bound_shooting(V, xmin, xmid, xmax, mass, ...
    Espan, EResolution, odeOpt)

% find the zeros in Psi(x_max) vs E plot
trial_fun = @(E) bound_shooting_trial(E, V, xmin, xmid, xmax, mass, odeOpt);
Eng = fzeroN(trial_fun, Espan, EResolution,0.01);

% output and plot.
NE = numel(Eng);
X = cell(1,NE); Psi = X;
for ii = 1:numel(Eng)
    [err, X{ii}, Psi{ii}] = trial_fun(Eng(ii));
    if (err > 1e-3)
        disp('bound state: '); disp(ii); disp('err ='); disp(err);
        error('something went wrong!');
    end
end
end
