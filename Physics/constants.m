% generate constants in physics and mathmetics
% run to update "constants.mat"

clear;
cd(mfilepath);

% =========== exact ==================================
c0 = 299792458;                        % speed of light
h = 6.62607015e-34;                    % Plank constant
hbar = h/(2*pi);                       % reduced Plank constant
e = 1.602176634e-19;                   % elementary charge
Na = 6.02214076e23;                    % Avogadro constant
kb = 1.380649e-23;                     % Boltzmann constant
R = Na*kb;                             % gas constant
u = 1e-3/Na;                           % atomic mass unit

% =========== measured =====================================
mu0 = 1.2566370621219e-6;              % vacuum permeability
epsilon0 = 1/(mu0*c0^2);               % vacuum permittivity
k = 1/(4*pi*epsilon0);                 % Coulomb's constant
G = 6.67408e-11;                       % gravitational constant
alpha = e^2/(4*pi*epsilon0*hbar*c0);   % fine structure constant
me = 9.10938215e-31;                   % electron mass
mp = 1.672621898e-27;                  % proton mass
Rh = me*e^4/(8*epsilon0^2*h^3*c0);     % Rydberg constant
a0 = 5.2917721067e-11;                 % Bohr radius

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

save constants.mat