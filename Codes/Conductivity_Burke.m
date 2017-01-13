% Calculate permittivity from Burke's paper
clc;
%% This section computes the dielectric constant
% Wafer A
% from Burke Paper
% High frequency conductivity of the high-mobility two-dimensional
% electron gas

% @ 10 K
% Wafer A
N = 1.6e11*1e4;
mu = 5.5*1e6*1e-4;

% D
% N = 2e11*1e4;
% mu = 15.6*1e6*1e-4;
m = 9.109e-31;
ms = .063*m;
q = 1.602e-19;
tr = mu*ms/q;

f = 1.25e9;
omega = 2*pi*f;

omega*tr;

sigma = N*q^2*tr/ms /(1 + 1i*omega*tr)

e1 = 10.89; % GaAs diecltric constant [2]
e0 = 8.85e-12;
ep = e1 - 1i*sigma/(omega*e0)


% Sample B
% Strontium Titanate
% M. Boucherit
% Extreme charge density SrTiO3/GdTiO3 heterostructure field effect transistors
% 
N = 1e14*1e4;
mu = 6*1e-4;

N = 1.1e14*1e4;
mu = 700*1e-4;

m = 9.109e-31;
ms = 6*m;
q = 1.602e-19;
tr = mu*ms/q;

f = 1e6;
omega = 2*pi*f;

omega*tr;

sigma = N*q^2*tr/ms /(1 + 1i*omega*tr)

e1 = 45; % GaAs diecltric constant [2]
e0 = 8.85e-12;
ep = e1 - 1i*sigma/(omega*e0)