% energy conversion: atomic unit to eV
function eV = au_E2eV(au)
load constants.mat au_E qe
eV = au*au_E/qe;
end
