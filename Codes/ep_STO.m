function ep =  ep_STO()
% Create Dielectric Constant of SrTi2O3
% Based on M. Boucherit
% Extreme charge density SrTiO3/GdTiO3 heterostructure 
% field effect transistors
lambda = 1;
load em_constants.mat
mu0 = mu_0;
ep0 = epsilon_0;
ep1 = 1;

%% Data from Paper
% N = 1e14*1e4; % Carrier density in cm^-2
% mu = 6*1e-4; % Mobility cm^2 /V/s

N = 1.1e14*1e4;
mu = 100*1e-4;

% N = 6e13*1e4;
% mu = 100*1e-4;

m = 9.109e-31; % Electron mass

ms = 6*m; % Effective mass of electron


q = 1.602e-19; % Electron Charge

% Relaxation time
tr = mu*ms/q;

% Frequency
f = 1e6;

% Angular frequency
omega = 2*pi*f;

% Drude conductivity
sigma = N*q^2*tr/ms /(1 + 1i*omega*tr);

e1 = 45; % GaAs diecltric constant [2]

% Frequency dependent epsilon
ep = e1 - 1i*sigma/(omega*ep0);