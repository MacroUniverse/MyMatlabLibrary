% convert electric field (au) to laser intensity (w/cm^2)
% verified, Brandsen eq 15.47
function w_cm2 = au_Ef2w_cm2(au)
load constants.mat epsilon0 c0 au_Ef
w_cm2 = 0.5e-4*epsilon0*c0*(au_Ef.*au).^2;
end
