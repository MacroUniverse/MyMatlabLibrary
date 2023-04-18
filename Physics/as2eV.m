% convert photon field period [as] to energy [eV]

function eV = as2eV(as)
load('constants.mat', 'qe', 'hbar');
eV = (2e18*pi*hbar/qe) ./ as;
end
