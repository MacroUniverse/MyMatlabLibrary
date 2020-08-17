% convert wavelength(nm) to photon energy (au)
function au = nm2au_E(nm)
load constants.mat h c0 au_E;
au = h*c0*1e9/(au_E*nm);
end
