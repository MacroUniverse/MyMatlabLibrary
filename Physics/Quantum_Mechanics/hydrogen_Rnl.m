% use Wolfram Alpha
% n = 3; l = 1; Sqrt[(2*Z/(n*a))^3 * Factorial[n-l-1]/(2*n*Factorial[n+l])]*(2*Z*r/(n*a))^l*LaguerreL[n-l-1, 2l+1, 2Z*r/(n*a)] * Exp[-Z*r/(n*a)]
% normalization and orthogonality are verified

Z = 2;

R10 = @(r) 2*Z^1.5 * exp(-Z*r);

R20 = @(r) 1/(2*sqrt(2)) * Z^1.5 * (2 - Z*r) .* exp(-0.5*Z*r);
R21 = @(r) 1/(2*sqrt(6)) * Z^1.5 * Z*r .* exp(-0.5*Z*r);

R30 = @(r) 2/(81*sqrt(3)) * Z^1.5 * ...
    (27 - 18*Z*r + 2 * Z^2 * r.^2) .* exp(-Z*r/3);
R31 = @(r) sqrt(2/3)/27 * Z^1.5 * (4 - 2*Z*r/3) .* Z .*r ...
    .* exp(-Z*r/3);
R32 = @(r) 2*sqrt(2/15)/81 * Z^1.5 * Z^2 * r.^2 ...
    .* exp(-Z*r/3);

R40 = @(r) 1/(768) * Z^1.5 * ...
    (192 - 144 * Z * r + 24 * Z^2 * r.^2 - (Z*r).^3)...
    .* exp(-Z*r/4);
R41 = @(r) 1/(256*sqrt(15)) * Z^1.5 * Z .* r ...
   .* ((Z*r).^2 - 20*Z*r + 80) .* exp(-Z*r/4);
R42 = @(r) 1/(384*sqrt(5)) * Z^1.5 .* (Z*r).^2 ...
    .* (6 - Z*r/2) .* exp(-Z*r/4);
R43 = @(r) 1/(768*sqrt(35)) * Z^4.5 .* r.^3 ...
    .* exp(-Z*r/4);

R50 = @(r) 2 *sqrt(Z^3)/(46875 *sqrt(5))...
    *(2 *r.^4 *Z^4 - 100 *r.^3 *Z^3 + 1500 *r.^2 *Z^2 - 7500* r* Z + 9375)...
    .* exp(-(r *Z)/5) ;
R51 = @(r) -(2 *sqrt(2/15) *Z^1.5)/46875 ...
    .* r *Z .* (2 *r.^3 *Z^3 - 90* r.^2 *Z^2 + 1125* r *Z - 3750) .* exp(-(r *Z)/5);
R52 = @(r) 2 *sqrt(2/35) * sqrt(Z^3) /46875 ...
    * r.^2 * Z^2 .* exp(-(r *Z)/5) .* (2 *r.^2 * Z^2 - 70* r* Z + 525);
R53 = @(r) sqrt(2/35) /9375 *(Z^3)^(3/2) * ...
    (8 - (2* r* Z)/5) .* r.^3 .* exp(-(r *Z)/5);
R54 = @(r) 2 * sqrt(2/35) * Z^1.5/140625 * Z^4 .* r.^4 ...
    .* exp(-(r *Z)/5);

%% plot

close all;
r = linspace(0, 30, 500);
figure; hold on;
plot(r, r.*R10(r));
plot(r, r.*R20(r));
plot(r, r.*R21(r));
plot(r, r.*R30(r));
plot(r, r.*R31(r));
plot(r, r.*R32(r));
plot(r, r.*R40(r));
plot(r, r.*R41(r));
plot(r, r.*R42(r));
plot(r, r.*R43(r));
plot(r, r.*R50(r));
plot(r, r.*R51(r));
plot(r, r.*R52(r));
plot(r, r.*R53(r));
plot(r, r.*R54(r));
legend({'1, 0', '2, 0', '2, 1', '3, 0', '3, 1', '3, 2', '4, 0', '4, 1', '4, 2', '4, 3', ...
    '5, 0', '5, 1', '5, 2', '5, 3', '5, 4'});
xlabel r;
title 'r R_{l,m}';
