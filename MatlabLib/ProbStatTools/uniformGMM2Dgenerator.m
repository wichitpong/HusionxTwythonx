% Generate a 2D GM with  
%   - uniform mean locations covering whole xMin, xMax, yMin, yMax space with distance dX,dY
%   - all covariance matrices are just identity matrix * sd!! TODO
%   - weights are uniform
%%
function [mus, Sigs, pwts] = uniformGMM2Dgenerator(xMin, xMax, yMin, yMax, dX, dY, sd)


%%%% GM parameters

% generate uniform Means of all mixands
muXspace = xMin+1:dX:xMax-1;
muYspace = yMin+1:dY:yMax-1;
numMixands = length(muXspace) * length(muYspace);%TODO!: parameter!
[muXmesh,muYmesh] = meshgrid(muXspace,muYspace);
muX = reshape(muXmesh, 1, numMixands);
muY = reshape(muYmesh, 1, numMixands);
mus = [muX;
       muY];
% mus = -6 + 12*rand(2,numMixands);


% all covariance matrices are just identity matrix!! TODO
Sig = sd*eye(2) ; 
Sigs = repmat(Sig,[1 1 numMixands]); % Stacked covariance


% Weights of all mixands are uniform
pwts = ones(1,numMixands)/numMixands; 
