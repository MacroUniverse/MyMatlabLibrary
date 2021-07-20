% convert wavelength [nm] to period [au]
function au = nm2au_t(nm)
load constants.mat au_t;
au = nm * (1e-9 / 299792458 / au_t);
end
