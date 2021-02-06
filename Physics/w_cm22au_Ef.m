% convert laser intensity (w/cm^2) to electric field (au)
% verified, Brandsen eq 15.47
function au = w_cm22au_Ef(w_cm2)
load constants.mat epsilon0 c0 au_Ef
au = sqrt(w_cm2./(0.5e-4*epsilon0*c0))./au_Ef;
end
