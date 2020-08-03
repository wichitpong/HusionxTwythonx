%% fuse step
% Use true if we want to visualize the output pdf for debugging
isPlotOutputPdf = true; % param

% Define human inputs
D = 1; % 1="Near" 2="Far" or 3="At"   % param
xl_in = [180 40]; % param


% The initial log(p(X)) input to husion                                    
lnpX = lnpXgivenD;

% Calculate p(D|X,xl_in) for the input word at current Husion time step
% % TODO: There might/will be discretization error up to the size of the grid resolution [resolutionX,resolutionY] 
lnpDgivenXandXl_input = lnpDGivenXfromWeights_singleD(weightMatrix, subclassToClassMapping, XterrainMesh,YterrainMesh, xl_in,D);

% Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
% ln p(D,X)
lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));

% ln p(D)
lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );
pD = exp(lnpD);

% ln p(X|D)
lnpXgivenD = lnpDandXgivenXl - lnpD;

%% Visualize husion output pdf

figure(2) %%%%figure(2)
surf(XterrainMesh,YterrainMesh, exp(lnpXgivenD'),'EdgeColor','none')
view(2)
 title(['Posterior Given Human Measurement p(x|{\zeta^{ HUMAN}}); D = ' num2str(D) ', x_{l} = [' num2str(xl_in(1)) ' ' num2str(xl_in(2)) ']^T '],'fontsize',15)
xlabel('x_0 (m)','fontsize',15)
ylabel('x_1 (m)','fontsize',15)
colorbar
colormap(jet)

hold on