About spherical harmonic expansion

Any well behaved 3D functions can be expanded by spherical harmonics in the angular directions

$$ f(\vec r) = sum_{l,m} R_{l,m}(r) Y_{l,m} $$

where $R_{l,m}(r)$ is call the radial function, and $r R_{l,m}(r)$ is the scaled radial function. In Matlab code, I use the cell array "fr" for either of them. Each element "fr{jj,kk}" is a row vector for the function values corresponding to "l(jj)" and "m(kk)" which are vectors of size "Nl" and "Nm". Usually, there is also a row vector "r" with Nr elements that specifies a radial grid, "fr{l,m}" must be either be empty or the same size as "r".

It is recommended to use all vectors as row vector when using "fr" related functions.

Handling "r = 0" : When radial grid 'r' includes "r = 0", we are assuming unscaled radial function is finite at the origin, so that the scaled function must be 0 at the origin. When converting scaled radial function to unscaled one, to avoid 'nan' at the origin, we use '1/r(2)' instead of '1/0' at the origin. Note that his will not affect dot product. Not including the origin in 'r', however, will affect the dot product, since the interval "[0, r(1)]" is not integrated when doing radial integration.
