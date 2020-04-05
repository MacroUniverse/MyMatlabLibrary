% generate a model spectrum
% val must be from 0 to 1, corresponding to 400nm to 800nm
function rgb = colormap_spec(val)
lambda = 430 + (650-430)*val;
rgb = nm2rgb(lambda);
end
