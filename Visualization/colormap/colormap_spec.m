% generate a model spectrum
% val must be from 0 to 1, corresponding to 400nm to 800nm
function rgb = colormap_spec(val)
lamb_min = 425; lamb_max = 650;
lambda = lamb_min + (lamb_max-lamb_min)*val;
rgb = nm2rgb(lambda);
end
