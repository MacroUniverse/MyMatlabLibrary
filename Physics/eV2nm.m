% convert photon energy (eV) to wavelength(nm)
function nm = eV2nm(eV)
load constants.mat c0 h qe
nm = c0*h*1e9/(qe*eV);
end
