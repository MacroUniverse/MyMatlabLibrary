% convert energy (eV) to atomic unit energy
function au = eV2au_E(eV)
load constants.mat qe au_E
au = qe/au_E*eV;
end
