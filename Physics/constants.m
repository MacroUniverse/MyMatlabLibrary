% generate constants in physics and mathmetics
% run to update "constants.mat"

clear;
cd(mfilepath);

c0=299792458;                        % speed of light  
mu0=4*pi*1e-7;                       % vacuum permeability 1.256637061435917e-06
epsilon0=1/mu0/c0^2;                 % vacuum permittivity   8.854187817620391e-12
k=1/(4*pi*epsilon0);                 % Coulomb's constant  8.987551787368176e+09
G=6.67408e-11;                       % gravitational constant
h=6.626070040e-34;                   % Plank constant 
h1=h/2/pi;                           % reduced Plank constant 1.054571800139113e-34
e=1.6021766208e-19;                  % electron charge
me=9.10938215e-31;                   % electron mass
mp=1.672621898e-27;                  % proton mass
Rh=1.0973731568539e+07;              % Rydberg constant    me*e^4/(8*epsilon0^2*h^3*c0);         
Na=6.022140857e23;                   % Avogadro constant
R=8.3144598;                         % Ideal Gas constant
kb=1.380650324e-23;                  % Boltzmann constant
u= 1.660539040e-27;                  % atomic mass unit
a0=5.2917721067e-11;                 % Bohr radius

% Mathematical Constants
E=exp(1);                            % base of the natural logarithm

% conversion constants

inch=2.54e-2; % length
gauss=1e-4;   % electric field
mile=6.09e+2; % length
lb=0.454; pound=0.454; % mass
au_x = 5.2917721067e-11;  % 1 a.u. distance
au_t = 2.418884326e-17;   % 1 a.u. time
au_E = 4.3597446499e-18;  % 1 a.u. energy
au_Ef = 5.1422067070e11;  % 1 a.u. electric field

% conversion functions
au_E2eV = @(x) 27.211386018871558*x; % au_E/e
eV2au_E = @(x) 0.036749322482379*x; % e/au_E
% wavelengt [nm] and photon energy [eV]
nm2eV = @(x) 1239.841973964072/x; % 2*pi*c0*h1*1e9/e
eV2nm = @(x) 1239.841973964072/x;
% wavelengt [nm] and photon energy [au]
nm2au_E = @(x) 45.56335252839456/x; % 2*pi*c0*h1*1e9/au_E
au_E2nm = @(x) 45.56335252839456/x;
% intensity (W/cm^2) TO electric field (a.u.)
w_cm22au_Ef = @(x)5.338026811839179e-09*sqrt(x); % sqrt(2e4/epsilon0/c0/au_Ef^2)
au_Ef2w_cm2 = @(x) 3.509445467042176e+16*x.^2; % epsilon0*c0*au_Ef^2*5e-5


save constants.mat