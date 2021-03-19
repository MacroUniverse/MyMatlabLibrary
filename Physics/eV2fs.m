% convert photon energy [eV] to field period [fs]

function fs = eV2fs(eV)
load('constants.mat', 'qe', 'hbar');
fs = (2e15*pi*hbar/qe) ./ eV;
end
