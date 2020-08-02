% This demo performs one step of human input update, calling functions from
% MatlabLib library (path = '..\' for windows)
% 
%%
% close all
% clear all
% clc

%% Add library paths
libPath = 'D:\Library\Documents\GitHub\Husion-Simulator\MatlabLib'; % path to MatlabLib folder; % param
addpath(genpath(libPath));
 

%%
%% Define MMS parameters
% number of words in the dictionary
dictionarySize = 3;

% The learned MMS weight matrix (size = [nDimensions+1, nSubclasses])
weightMatrix = ... % 8 faces
[        0    1.4672    2.0749    1.4672         0   -1.4672   -2.0749   -1.4672    0.0000   4.0273    5.6954     4.0273    0.0000   -4.0273   -5.6954   -4.0273     0;
    2.0749    1.4672   -0.0000   -1.4672   -2.0749   -1.4672         0    1.4672    5.6954   4.0273    -0.0000   -4.0273   -5.6954   -4.0273    0.0000    4.0273     0;
   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208  -12.8229   -12.8229  -12.8229  -12.8229  -12.8229  -12.8229  -12.8229  -12.8229    0];
% weightMatrix = ... % 12 faces
% [-0.0000    1.0520    1.8222    2.1041    1.8222    1.0520    0.0000   -1.0520   -1.8222    -2.1041   -1.8222   -1.0520    0.0000   -2.9277   -5.0709   -5.8554   -5.0709   -2.9277     0.0000    2.9277    5.0709    5.8554    5.0709    2.9277    0.0000;
%     2.1041    1.8222    1.0520    0.0000   -1.0520   -1.8222   -2.1041   -1.8222   -1.0520  0.0000    1.0520    1.8222   -5.8554   -5.0709   -2.9277    0.0000    2.9277    5.0709      5.8554    5.0709    2.9277    0.0000   -2.9277   -5.0709    0.0000;
%    -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532  -4.0532   -4.0532   -4.0532  -13.6126  -13.6126  -13.6126  -13.6126  -13.6126  -13.6126     -13.6126  -13.6126  -13.6126  -13.6126  -13.6126  -13.6126       0];
% weightMatrix = ... % 16 faces
% [0.0000    0.8077    1.4924    1.9499    2.1106    1.9499    1.4924    0.8077    0.0000        -0.8077   -1.4924   -1.9499   -2.1106   -1.9499   -1.4924   -0.8077    0.0000   -2.2693  -4.1931   -5.4785   -5.9299   -5.4785   -4.1931   -2.2693    0.0000    2.2693    4.1931     5.4785    5.9299    5.4785    4.1931    2.2693    0.0000;
%     2.1106    1.9499    1.4924    0.8077    0.0000   -0.8077   -1.4924   -1.9499   -2.1106     -1.9499   -1.4924   -0.8077    0.0000    0.8077    1.4924    1.9499   -5.9299   -5.4785  -4.1931   -2.2693    0.0000    2.2693    4.1931    5.4785    5.9299    5.4785    4.1931     2.2693         0   -2.2693   -4.1931   -5.4785    0.0000;
%    -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474     -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747    -14.0747  -14.0747  -14.0747  -14.0747  -14.0747       0];
% weightMatrix = ... % 32 faces
% [    0.0000   -0.4115   -0.8072   -1.1719   -1.4916   -1.7539   -1.9488   -2.0689   -2.1094     -2.0689   -1.9488   -1.7539   -1.4916   -1.1719   -0.8072   -0.4115    0.0000    0.4115     0.8072    1.1719    1.4916    1.7539    1.9488    2.0689    2.1094    2.0689    1.9488      1.7539    1.4916    1.1719    0.8072    0.4115         0    1.1542    2.2641    3.2869      4.1834    4.9192    5.4659    5.8026    5.9163    5.8026    5.4659    4.9192    4.1834     3.2869    2.2641    1.1542         0   -1.1542   -2.2641   -3.2869   -4.1834   -4.9192      -5.4659   -5.8026   -5.9163   -5.8026   -5.4659   -4.9192   -4.1834   -3.2869   -2.2641     -1.1542    0.0000;
%    -2.1094   -2.0689   -1.9488   -1.7539   -1.4916   -1.1719   -0.8072   -0.4115         0      0.4115    0.8072    1.1719    1.4916    1.7539    1.9488    2.0689    2.1094    2.0689      1.9488    1.7539    1.4916    1.1719    0.8072    0.4115    0.0000   -0.4115   -0.8072    -1.1719   -1.4916   -1.7539   -1.9488   -2.0689    5.9163    5.8026    5.4659    4.9192          4.1834    3.2869    2.2641    1.1542    0.0000   -1.1542   -2.2641   -3.2869   -4.1834      -4.9192   -5.4659   -5.8026   -5.9163   -5.8026   -5.4659   -4.9192   -4.1834   -3.2869     -2.2641   -1.1542    0.0000    1.1542    2.2641    3.2869    4.1834    4.9192    5.4659      5.8026   -0.0000;
%    -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392     -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392     -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392     -5.0392   -5.0392   -5.0392   -5.0392   -5.0392  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346         0];

% Number of class partition coundary faces
nFaces = (size(weightMatrix,2) - 1)/2;   
  
% Define mapping from subclass to class
% subclassToClassMapping = ... % 8 faces
% [1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 3]; % column = subclass, number = class
% subclassToClassMapping = ... % 12 faces
% [1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 3]; % column = subclass,
% number = class
% subclassToClassMapping = ... % 16 faces
% [1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 2 3]; %
% column = subclass, number = class
% General nFaces:
subclassToClassMapping = [ones(1,nFaces) 2*ones(1,nFaces) 3];

%%
%% Define husion parameters and inputs
% Use true if we want to visualize the output pdf for debugging
isPlotOutputPdf = true; % param

% Define human inputs
D = 3; % 1="Near" 2="Far" or 3="At"   % param
xl_in = [20 20]; % param

% Define terrain grid parameters
xTerrainMin = 0; %-20; % meters     % param
xTerrainMax = 200; % meters         % param
yTerrainMin = 0;% -10; % meters     % param
yTerrainMax = 100; % meters          % param
xGridResolution = 0.25; % meters    % param
yGridResolution = xGridResolution; % meters 

% Setup terrain grid 
xGrid = xTerrainMin:xGridResolution:xTerrainMax;
yGrid = yTerrainMin:yGridResolution:yTerrainMax;
[XterrainMesh, YterrainMesh] = meshgrid(xGrid, yGrid);


%% Define prior distribution p(X) as a uniform Gaussian mixture

% Define uniform GM parameters
dXmixand = 7;%2%LOW_RES 
dYmixand = 7;%2%LOW_RES 
sdMixand = 15;%5%LOW_RES 
priorTerrainMargin = 20;

XYmesh = [XterrainMesh(:), YterrainMesh(:)]; % (:) unrolls all columns of XterrainMesh into a single column vector

% Generate uniform GM
priorGMdistributionXY = GenerateUniformGMpX(isPlotOutputPdf, dXmixand,dYmixand,sdMixand,priorTerrainMargin, ...
                                        xTerrainMin,xTerrainMax,yTerrainMin,yTerrainMax, ...
                                        XYmesh,XterrainMesh,YterrainMesh);

% The initial log(p(X)) input to husion                                    
lnpX = log(priorGMdistributionXY);

% Clear unused variables
clear priorGMdistributionXY XYmesh
                                    
%% Run one step of husion

%% MMS Likelihood calculation
% Calculate p(D|X,xl_in) for the input word at current Husion time step
% % TODO: There might/will be discretization error up to the size of the grid resolution [resolutionX,resolutionY] 
lnpDgivenXandXl_input = lnpDGivenXfromWeights_singleD(weightMatrix, subclassToClassMapping, XterrainMesh,YterrainMesh, xl_in,D);
    
    
%% Bayesian fusion step
%            Husion p(X|D) = p(D|X)p(X)/p(D); 
%             where p(D) = Integral{ p(D|X)p(X) }dX
% 
%       or   ln p(X|D) = ln p(D,X) - ln p(D)           -(*)
%             where ln p(D,X) = ln p(D|X) + ln p(X)    -(1)
% 
%               Define:
%                   ln_maxval := ln p(D,X)max = max_X( ln p(D,X) ) % This is just a fixed number used to offset the values 
% 
%                   ln p(D) = ln Integral{ p(D,X) }dX  
%                           = ln_maxval + ln Integral{ exp { ln p(D,X) - ln_maxval } }dX  -(**)

% Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
% ln p(D,X)
lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));

% ln p(D)
lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );

% ln p(X|D)
lnpXgivenD = lnpDandXgivenXl - lnpD;
    

%% Visualize husion output pdf

figure(2) %%%%figure(2)
surf(XterrainMesh,YterrainMesh, exp(lnpXgivenD'),'EdgeColor','none')
view(2)
 title(['Posterior Given Human Measurement p(x|{\zeta^{ HUMAN}}); D = ' num2str(D) ', x_{l} = [' num2str(xl_in(1)) ' ' num2str(xl_in(2)) ']^T '],'fontsize',15)
xlabel('x_0 (m)','fontsize',15)
ylabel('x_1 (m)','fontsize',15)
% xlabel('$x_0$ (m)','fontsize',12,'interpreter','latex')
% ylabel('$x_1$ (m)','fontsize',12,'interpreter','latex')
colorbar    
colormap(jet)

% %% fuse step 2
% % Use true if we want to visualize the output pdf for debugging
% isPlotOutputPdf = true; % param
% 
% % Define human inputs
% D = 2; % 1="Near" 2="Far" or 3="At"   % param
% xl_in = [20 20]; % param
% 
% 
% % The initial log(p(X)) input to husion                                    
% lnpX = lnpXgivenD;
% 
% % Calculate p(D|X,xl_in) for the input word at current Husion time step
% % % TODO: There might/will be discretization error up to the size of the grid resolution [resolutionX,resolutionY] 
% lnpDgivenXandXl_input = lnpDGivenXfromWeights_singleD(weightMatrix, subclassToClassMapping, XterrainMesh,YterrainMesh, xl_in,D);
% 
% % Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
% % ln p(D,X)
% lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
% lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));
% 
% % ln p(D)
% lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );
% pD = exp(lnpD);
% 
% % ln p(X|D)
% lnpXgivenD = lnpDandXgivenXl - lnpD;
% 
% %% Visualize husion output pdf
% 
% figure(2) %%%%figure(2)
% surf(XterrainMesh,YterrainMesh, exp(lnpXgivenD'),'EdgeColor','none')
% view(2)
%  title(['Posterior Given Human Measurement p(x|{\zeta^{ HUMAN}}); D = ' num2str(D) ', x_{l} = [' num2str(xl_in(1)) ' ' num2str(xl_in(2)) ']^T '],'fontsize',15)
% xlabel('x_0 (m)','fontsize',15)
% ylabel('x_1 (m)','fontsize',15)
% colorbar
% colormap(jet)
% 
% hold on

% %% fuse step 3
% % Use true if we want to visualize the output pdf for debugging
% isPlotOutputPdf = true; % param
% 
% % Define human inputs
% D = 3; % 1="Near" 2="Far" or 3="At"   % param
% xl_in = [14 12]; % param
% 
% 
% % The initial log(p(X)) input to husion                                    
% lnpX = lnpXgivenD;
% 
% % Calculate p(D|X,xl_in) for the input word at current Husion time step
% % % TODO: There might/will be discretization error up to the size of the grid resolution [resolutionX,resolutionY] 
% lnpDgivenXandXl_input = lnpDGivenXfromWeights_singleD(weightMatrix, subclassToClassMapping, XterrainMesh,YterrainMesh, xl_in,D);
% 
% % Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
% % ln p(D,X)
% lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
% lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));
% 
% % ln p(D)
% lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );
% pD = exp(lnpD);
% 
% % ln p(X|D)
% lnpXgivenD = lnpDandXgivenXl - lnpD;
% 
% %% Visualize husion output pdf
% 
% figure(2) %%%%figure(2)
% surf(XterrainMesh,YterrainMesh, exp(lnpXgivenD'),'EdgeColor','none')
% view(2)
%  title(['Posterior Given Human Measurement p(x|{\zeta^{ HUMAN}}); D = ' num2str(D) ', x_{l} = [' num2str(xl_in(1)) ' ' num2str(xl_in(2)) ']^T '],'fontsize',15)
% xlabel('x_0 (m)','fontsize',15)
% ylabel('x_1 (m)','fontsize',15)
% colorbar
% colormap(jet)
% 
% hold on