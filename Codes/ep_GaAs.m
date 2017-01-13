function ep =  ep_GaAs()
% Create Dielectric Constant of GaAS
% Based on Burke's paper
% % High frequency conductivity of the high-mobility two-dimensional
% electron gas
lambda = 1;
load em_constants.mat
mu0 = mu_0;
ep0 = epsilon_0;
ep1 = 1;

%% Data from Paper
% N = 2e11*1e4; % Carrier density in cm^-2
% mu = 15.6e6*1e-4; % Mobility cm^2 /V/s

N = 1.6e11*1e4;
mu = 5.5*1e6*1e-4;

m = 9.109e-31; % Electron mass

ms = .063*m; % Effective mass of electron


q = 1.602e-19; % Electron Charge

% Relaxation time
tr = mu*ms/q;

% Frequency
f = 1.25e9;

% Angular frequency
omega = 2*pi*f;

% Drude conductivity
sigma = N*q^2*tr/ms /(1 + 1i*omega*tr);

e1 = 10.89; % GaAs diecltric constant [2]

% Frequency dependent epsilon
ep = e1 - 1i*sigma/(omega*ep0);