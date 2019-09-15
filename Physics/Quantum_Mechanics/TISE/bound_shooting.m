% solve bound state energies of 1D potential
% shooting from both side, then match at some middle point
% varargin are options for ode45 solver
% Eng(i) is the bound state i energies
% psi(:,i) is the wave function of Eng(i)
% output Y = [psi(x); psi'(x)]
function [Eng, X, Psi] = bound_shooting(V, xmin, xmid, xmax, mass, ...
    Espan, EResolution, odeOpt, plot_flag)

% find the zeros in Psi(x_max) vs E plot
trial_fun = @(E) bound_shooting_trial(E, V, xmin, xmid, xmax, mass, odeOpt);
Eng = fzeroN(trial_fun, Espan, EResolution);

% output, check nodes
X = cell(1,numel(Eng)); Psi = X;
for i = 1:numel(Eng)
    [~, X{i}, Psi{i}] = trial_fun(Eng(i));
    if numzero(Psi{i}) > i - 1
        warning(['missed bound state ', num2str(i),...
            ', increase Eresolution!']);
    elseif numzero(Psi{i}) < i - 1
        error('duplicate bound state found!');
    end
    
    if plot_flag
        x = X{i}; psi = Psi{i};
        figure; plot(x,psi); axis([x(1),x(end),-1.2,1.2]);
        hold on;
        xlabel('x'); ylabel('\psi(x)');
        Nzeros = numzero(psi);
        title(['i = ', num2str(i),...
            ', E_{', num2str(Nzeros+1), '} = ',  num2str(Eng(i))]);
        scatter(xmid,0);
    end
end
end
