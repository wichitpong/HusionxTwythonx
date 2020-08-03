%% This function outputs the log likeliood ln(p(D|X)) over the given X0mesh,X1mesh space
% It is the same as function lnpDGivenXfromWeights(), but only calculates the likelihood 
% for one specific preposition D given inorder to save calculation time.
% 
% Inputs:
% weightMatrix = [nSubclasses x nDimensions+1] matrix containing MMS weight parameters (column vector weights)
%                of each subclass (one subclass = one row vector of length nDimensions+1)
% subclassToClassMapping = [1 x nSubclasses] row vector containing mainclass
%                          label of each subclass,
%                          NOTE: Each subclass's index follows row index in weightMatrix
% X0mesh,X1mesh = target location (X0,X1) space
% xl = landmark location
% Outputs:
% logpDGivenX_singleD = The likelihood ln(p(D|X)) for the input D, over the given X0mesh,X1mesh space
function [logpDGivenX_singleD] = lnpDGivenXfromWeights_singleD(weightMatrix, subclassToClassMapping, X0mesh,X1mesh, xl,D) 
%% Get number of subclasses and data space dimension
[~,nSubclasses] = size(weightMatrix); % [a,nSubclasses] = size(weightMatrix);
% % Debugging: report MMS parameters
% nDimensions = a-1; %weight vector length = nDimension + 1(bias)
% nClasses = max(subclassToClassMapping);
% nSubclasses
% nDimensions


%% Initialize result memory storage
% % NOTE: COLUMN major convention for mesh plotting!!: to visualize, try [x, y]=meshgrid(1:5,1:4)
% logpDGivenX_singleD = zeros(size(X0mesh, 2), size(X0mesh, 1));
% logpSGivenX = zeros(size(X0mesh, 2), size(X0mesh, 1), nSubclasses);
expWtXsubclass_substract = zeros(size(X0mesh, 2), size(X0mesh, 1), nSubclasses);
maxWtXsubclass = zeros(size(X0mesh, 2), size(X0mesh, 1));


%% Calculate MMS exponent term for each subclass
% Stacked [x0; x1] = column X vector
x0List = X0mesh(1,:);
x1List = X1mesh(:,1)';
% for all (X0,X1)=(ii,jj) locations on the plotting domain X, calc numerator for each subclass = exp(wTx)
for ii = 1:length(x0List)
    for jj = 1:length(x1List)
        % MMS exponent for all subclasses
        exponentVect = weightMatrix'*[x0List(ii)-xl(1); x1List(jj)-xl(2); 1]; %(column vector weights & X)
        % log of sum trick
        maxWtXsubclass_iijj = max(exponentVect);
        maxWtXsubclass(ii,jj) = maxWtXsubclass_iijj;
        expWtXsubclass_substract(ii,jj,:) = exp(exponentVect - maxWtXsubclass_iijj);
    end
end

%% Denominator = sum( exponents of all subclasses )
% same at all locations (ii,jj) 
logDenominator = log(sum(expWtXsubclass_substract,3));



%% MMS log likelihood = log(numerator) - log(denominator)
% where numerator = sum ( exponents of all subclasses belonging to class D )
logpDGivenX_singleD = log( sum(expWtXsubclass_substract(:,:, subclassToClassMapping==D) , 3) ) - logDenominator;            


%% Subclass visualization
% % TODO: to save time, need not calculate this
% % subclass MMS likelihood: p(S=s|X)
% for ii = 1:length(x0List) 
%     for jj = 1:length(x1List)
%         logpSGivenX(ii,jj,:) = log(expWtXsubclass_substract(ii,jj,:)) - logDenominator(ii,jj);
%     end
% end