% photon energy (au) to wave length (nm)
function nm = au_E2nm(au)
load constants.mat h c0 au_E;
nm = h*c0*1e9/(au*au_E);
end
