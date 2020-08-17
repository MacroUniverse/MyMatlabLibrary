% generate constants in physics and mathmetics
% 2018 CODATA from https://physics.nist.gov/cuu/Constants/Table/allascii.txt
% run to update "constants.mat"

clear;
cd(mfilepath);

% =========== exact ==================================
c0 = 299792458;                        % speed of light
h = 6.62607015e-34;                    % Plank constant
hbar = h/(2*pi);                       % reduced Plank constant
qe = 1.602176634e-19;                   % elementary charge
Na = 6.02214076e23;                    % Avogadro constant
kb = 1.380649e-23;                     % Boltzmann constant
R = Na*kb;                             % gas constant
u = 0.9999999996530e-3/Na;             % atomic mass unit

% =========== measured =====================================
mu0 = 1.2566370621219e-6;              % vacuum permeability
epsilon0 = 1/(mu0*c0^2);               % vacuum permittivity
k = 1/(4*pi*epsilon0);                 % Coulomb's constant
G = 6.67430e-11;                       % gravitational constant
alpha = qe^2/(4*pi*epsilon0*hbar*c0);   % fine structure constant
me = 9.1093837015e-31;                 % electron mass
mp = 1.67262192369e-27;                % proton mass
Rh = 1.0973731568160e7;                % Rydberg constant
a0 = 5.29177210903e-11;                % Bohr radius

% Mathematical Constants
E=exp(1);                            % base of the natural logarithm

% conversion constants

inch=2.54e-2; % length
gauss=1e-4;   % electric field
mile=6.09e+2; % length
lb=0.454; pound=0.454; % mass
au_x = a0;  % 1 a.u. distance
au_t = me*a0^2/hbar;   % 1 a.u. time
au_E = hbar^2/(me*a0^2);  % 1 a.u. energy
au_Ef = qe/(4*pi*epsilon0*a0^2);  % 1 a.u. electric field

save constants.mat