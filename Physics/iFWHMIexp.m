% if the E-field envelope is exp(-ax^2)
% then output FWHMI, satisfying:
% exp(-a*(FWHMI/2)^2)^2 = 1/2

function a = iFWHMIexp(FWHMI)
a = 2*log(2) / FWHMI^2;
end
