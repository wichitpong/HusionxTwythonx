% Generate Uniform GM prior p(X)
% % Uniform GM
% % Recommended parameters for uniform GMM prior over vicon field map:
% dXmixand = 7%2%LOW_RES %7
% dYmixand = 7%2%LOW_RES %7
% sdMixand = 15%5%LOW_RES %15
% priorTerrainMargin = 20
%%
function priorGMdistributionXY = GenerateUniformGMpX(isPlotOutputPdf, dXmixand,dYmixand,sdMixand,priorTerrainMargin, xTerrainMin, xTerrainMax, yTerrainMin, yTerrainMax, XYmesh, XterrainMesh, YterrainMesh)

% % Test GM: random GM
% priorNumMixands = 5
% [priorGMmeans, priorGMcov, priorGMweights] = randomGMM2Dgenerator(priorNumMixands, xTerrainMin, xTerrainMax, yTerrainMin, yTerrainMax);


[priorGMmeans, priorGMcov, priorGMweights] = uniformGMM2Dgenerator(xTerrainMin-priorTerrainMargin, xTerrainMax+priorTerrainMargin, yTerrainMin-priorTerrainMargin, yTerrainMax+priorTerrainMargin, ...
                                                                                dXmixand, dYmixand, sdMixand);
% priorNumMixands = length(priorGMweights);

% Generate the GMM object
GMMobject = gmdistribution(priorGMmeans',priorGMcov,priorGMweights);

% Generate GM values from the GM object over the specified XYmesh grid 
priorGMdistributionXYtemp = reshape(pdf(GMMobject,XYmesh),size(XterrainMesh));
priorGMdistributionXY = priorGMdistributionXYtemp'; clear priorGMdistributionXYtemp


pXsum = sum(sum(priorGMdistributionXY,1),2);%squeeze(sum(sum(pX(:,:,word),1),2))
priorGMdistributionXY = priorGMdistributionXY/pXsum;

% % Or, just use perfect uniform
% priorGMdistributionXY = ones(numTerrainPixelsX, numTerrainPixelsY)/(numTerrainPixelsX*numTerrainPixelsY);


%%get marginal x pdf
% xprobdist = gmdistribution(priorGMmeans(1,:)',priorGMcov(1,1,:),priorGMweights);
% xprobdistx = pdf(xprobdist,x')';


if isPlotOutputPdf
    % Plot the prior GM pdf
    figure()%figure(nClasses+1)
    surf(XterrainMesh,YterrainMesh,priorGMdistributionXY','EdgeColor','none')
%     surf(XterrainMesh,YterrainMesh,log(priorGMdistributionXY)','EdgeColor','none')
    view(2)
    title('Prior GM pdf')
    colorbar

    % printpdf(figure(nClasses+1), 'GMprior_pX')
end
