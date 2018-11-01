% radial "probability" distribution of "fr" wave-function
% 'scaled = true' for scaled wave function, default is 'false'

function dpdr = fr_dpdr(fr,r,scaled)
[Nl, Nm] = size(fr);
dpdr = zeros(size(r));
for ii = 1:Nl
for jj = 1:Nm
    if ~isempty(fr{ii,jj})
        dpdr = dpdr + abs(fr{ii,jj}).^2;
    end
end
end

if nargin < 3 || ~scaled % unscaled
    dpdr = dpdr.*r.^2;
end
end
