% convert wavelength [nm] to period [fs]
function fs = nm2fs(nm)
fs = nm * (1e6 / 299792458);
end
