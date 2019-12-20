% generate fr function
% input functon fun(r, th, ph) should be vectorized
function fr = fr_fun(fun, r, l, m, scaled, varargin)
Nr = numel(r); Nl = numel(l); Nm = numel(m);
fr = cell(Nl, Nm);
for j = 1:Nl
    for k = 1:Nm
        fr{j, k} = zeros(1, Nr);
        for i = 1:Nr
            f = @(th, ph) conj(SphHarm(l(j), m(k), th, ph)) .* fun(r(i),th,ph) .* sin(th);
            fr{j, k}(i) = integral2(f,0,pi,0,2*pi,varargin{:});
        end
        if scaled
            fr{j, k} = fr{j, k} .* r;
        end
    end
end
end
