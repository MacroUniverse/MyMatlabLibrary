% energy conversion: atomic unit to eV
function eV = au_E2eV(au)
load constants.mat au_E e
eV = au*au_E/e;
end
