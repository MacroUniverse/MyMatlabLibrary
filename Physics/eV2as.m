% convert photon energy [eV] to field period [as]

function as = eV2as(eV)
load('constants.mat', 'qe', 'hbar');
as = (2e18*pi*hbar/qe) ./ eV;
end
