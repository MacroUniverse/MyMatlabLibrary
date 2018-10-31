About spherical harmonic expansion

Any well behaved 3D functions can be expanded by spherical harmonics in the angular directions

$f(\vec r) = sum_{l,m} R_{l,m}(r) Y_{l,m}$

where $R_{l,m}(r)$ is call the radial function, and $r R_{l,m}(r)$ is the scaled radial function. In Matlab code, I use the cell array "fr" for both of them. Each element "fr{jj,kk}" is a row vector for the function values corresponding to "l{jj}" and "m{kk}" which are vectors of size "Nl" and "Nm". Usually, there is also a row vector "r" with Nr elements that specifies a radial grid, "fr{l,m}" must be either be empty or the same size as "r".
