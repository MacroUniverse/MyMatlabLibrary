% convert wavelength(nm) to photon energy (eV)
function eV = nm2eV(nm)
load constants.mat c0 h qe
eV = c0*h*1e9/(qe*nm);
end
