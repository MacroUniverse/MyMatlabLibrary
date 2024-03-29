% if the E-field envelope is exp(-ax^2)
% then output FWHMI, satisfying:
% exp(-a*(FWHMI/2)^2)^2 = 1/2
% ref: https://wuli.wiki/online/GausPD.html

function FWHMI = FWHMIexp(a)
    FWHMI = sqrt(2*log(2) / a);
end
