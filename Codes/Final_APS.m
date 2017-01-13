% This code plots the figures used in the 2017 APS paper
% Plots 
% 1. Current Distribution
% 2. RCS 
% A comparison of different materials with PEC is also done
%

clear; close all
lambda = 1;
load em_constants.mat
mu0 = mu_0;
ep0 = epsilon_0;
ep1 = 1;
eta0 = sqrt(mu0/ep0);
omega = 2*pi*c/lambda;
K0 = omega*sqrt(mu0*ep0*ep1);

%% This section computes the dielectric constant and corresponding material propaerties
ep_GaAs = ep_GaAs();
ep_STO = ep_STO();

K_GaAs = omega*sqrt(mu0*ep0*ep_GaAs);
K_STO = omega*sqrt(mu0*ep0*ep_STO);



%% Structure Parameters
L = 3*lambda; % Lengths
M = 301; % Sections  on the strip
deltax = L / M; %Increment
x = linspace(0  , L , M); % length vector
num_theta = 720;
theta = linspace(0,pi,num_theta);

% Incident Angle 
phi = 2*pi/2;

%% Find currents
[I_pec, Z_pec] = current_pec(K0, x, deltax, phi);
[I_GaAs, Z_GaAs] = current_dielectric(K0, K_GaAs, x, deltax, phi);
[I_STO, Z_STO] = current_dielectric(K0, K_STO, x, deltax, phi);

%% Far-field
E_pec = farfield(num_theta, K0, Z_pec, x, deltax, eta0); 
E_GaAs = farfield(num_theta, K0, Z_GaAs, x, deltax, eta0); 
E_STO = farfield(num_theta, K0, Z_STO, x, deltax, eta0); 
%% Plot Current
figure (1)

N = 2; % Number of colors to be used
% Use Brewer-map color scheme SET1
axes('ColorOrder',brewermap(N,'Set1'),'NextPlot','replacechildren')

h3 = plot(x, abs(I_pec), 'linewidth',1.4, 'color', 'black', 'LineStyle',':');
hold on
h2 = plot(x, abs(I_STO), 'linewidth',1.4, 'LineStyle','-.');
h1 = plot(x, abs(I_GaAs), 'linewidth',1.4);
set(gcf,'Color','white'); % Set background color to white
% set(gca,'FontName','times new roman','FontSize',11) % Set axes fonts to Times New Roman
hold on
% legend([h1 h2 h3],{'$\mathrm{GaAs}: \varepsilon = 10.89 - j 3.75\times 10^{-8}$', '$\mathrm{SrTiO_3}: \varepsilon = 45 - j 2.71\times 10^{-7}$', '$\mathrm{PEC}$'},...
%      'location','northwest','interpreter','latex');
formatSpec1 = ' %0.2f - j%0.2f';
GaAs = [ '$\E_{GaAs} = $',sprintf(formatSpec1,real(ep_GaAs),abs(imag(ep_GaAs)))];
% GaAs = sprintf(formatSpec1,real(ep_GaAs),abs(imag(ep_GaAs)));

formatSpec2 = ' %0.2f - j%0.2f';
STO = [ '$\E_{STO} = $',sprintf(formatSpec2,real(ep_STO),abs(imag(ep_STO)))];
 legend([h1 h2 h3],{GaAs, STO, '$\mathrm{PEC}$'},...
     'location','northwest','interpreter','latex');
 

xlabel('$x/\lambda$','interpreter','latex')
ylabel('$\vert\mathrm J_z \vert (\mathrm{a.u.})$','interpreter','latex')
grid on
box on
cleanfigure();
if phi == pi
    ylim([0 15])
    matlab2tikz('filename',sprintf('currents_edgeon_%d.tex',L));
else
    matlab2tikz('filename',sprintf('currents_normal_%d.tex',L));
end    


%% Plot Far-field
figure(2)
N = 3; % Number of colors to be used
% Use Brewer-map color scheme SET1
axes('ColorOrder',brewermap(N,'Set1'),'NextPlot','replacechildren')
h4 = plot(theta, E_GaAs - 63, 'linewidth',1.4);
hold on
h5 = plot(theta, E_STO - 63, 'linewidth',1.4, 'LineStyle','-.');
h6 = plot(theta, E_pec - 63, 'linewidth',1.4, 'color', 'black', 'LineStyle',':');
legend([h4 h5 h6],{GaAs, STO, '$\mathrm{PEC}$'},...
     'location','northwest','interpreter','latex'); 
ax = gca;
set(gcf,'Color','white'); % Set background color to white
% set (gca,'FontName','times new roman') % Set axes fonts to Times New Roman
xlim([ 0 pi/2]);
% ylim([ -45 5]);
ax.XTick = [0 pi/4 pi/2 3*pi/4 pi];
ax.XTickLabel = { '0', '\pi/4','\pi/2','3\pi/4','\pi'};
xlabel('$\phi \mathrm{(rad)}$','interpreter','latex')
ylabel('$\sigma_{\theta} \mathrm{(dB)}$','interpreter','latex')
grid on
box on
% ylim([0 10])
cleanfigure();
matlab2tikz('filename',sprintf('farfield_%d.tex',L));



