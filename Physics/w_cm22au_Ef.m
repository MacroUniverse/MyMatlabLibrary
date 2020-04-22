% convert laser intensity (w/cm^2) to electric field (au)
function au_Ef = w_cm22au_Ef(w_cm2)
au_Ef = 5.338026811839179e-09*sqrt(w_cm2);
end
