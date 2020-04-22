% convert electric field (au) to laser intensity (w/cm^2)
function w_cm2 = au_Ef2w_cm2(au_Ef)
w_cm2 = 3.509445467042176e+16*au_Ef.^2;
end
