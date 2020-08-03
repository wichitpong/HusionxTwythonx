classdef Fusion < handle
    properties
        Prior
        weightMatrix = ...
        [        0    1.4672    2.0749    1.4672         0   -1.4672   -2.0749   -1.4672    0.0000   4.0273    5.6954     4.0273    0.0000   -4.0273   -5.6954   -4.0273     0;
            2.0749    1.4672   -0.0000   -1.4672   -2.0749   -1.4672         0    1.4672    5.6954   4.0273    -0.0000   -4.0273   -5.6954   -4.0273    0.0000    4.0273     0;
           -3.6208   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208   -3.6208  -12.8229   -12.8229  -12.8229  -12.8229  -12.8229  -12.8229  -12.8229  -12.8229    0]
%         weightMatrix = ... % 12 faces
%         [-0.0000    1.0520    1.8222    2.1041    1.8222    1.0520    0.0000   -1.0520   -1.8222    -2.1041   -1.8222   -1.0520    0.0000   -2.9277   -5.0709   -5.8554   -5.0709   -2.9277     0.0000    2.9277    5.0709    5.8554    5.0709    2.9277    0.0000;
%             2.1041    1.8222    1.0520    0.0000   -1.0520   -1.8222   -2.1041   -1.8222   -1.0520  0.0000    1.0520    1.8222   -5.8554   -5.0709   -2.9277    0.0000    2.9277    5.0709      5.8554    5.0709    2.9277    0.0000   -2.9277   -5.0709    0.0000;
%            -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532   -4.0532  -4.0532   -4.0532   -4.0532  -13.6126  -13.6126  -13.6126  -13.6126  -13.6126  -13.6126     -13.6126  -13.6126  -13.6126  -13.6126  -13.6126  -13.6126       0];
%         weightMatrix = ... % 16 faces
%         [0.0000    0.8077    1.4924    1.9499    2.1106    1.9499    1.4924    0.8077    0.0000        -0.8077   -1.4924   -1.9499   -2.1106   -1.9499   -1.4924   -0.8077    0.0000   -2.2693  -4.1931   -5.4785   -5.9299   -5.4785   -4.1931   -2.2693    0.0000    2.2693    4.1931     5.4785    5.9299    5.4785    4.1931    2.2693    0.0000;
%             2.1106    1.9499    1.4924    0.8077    0.0000   -0.8077   -1.4924   -1.9499   -2.1106     -1.9499   -1.4924   -0.8077    0.0000    0.8077    1.4924    1.9499   -5.9299   -5.4785  -4.1931   -2.2693    0.0000    2.2693    4.1931    5.4785    5.9299    5.4785    4.1931     2.2693         0   -2.2693   -4.1931   -5.4785    0.0000;
%            -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474     -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474   -4.3474  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747  -14.0747    -14.0747  -14.0747  -14.0747  -14.0747  -14.0747       0];
%         weightMatrix = ... % 32 faces
%         [    0.0000   -0.4115   -0.8072   -1.1719   -1.4916   -1.7539   -1.9488   -2.0689   -2.1094     -2.0689   -1.9488   -1.7539   -1.4916   -1.1719   -0.8072   -0.4115    0.0000    0.4115     0.8072    1.1719    1.4916    1.7539    1.9488    2.0689    2.1094    2.0689    1.9488      1.7539    1.4916    1.1719    0.8072    0.4115         0    1.1542    2.2641    3.2869      4.1834    4.9192    5.4659    5.8026    5.9163    5.8026    5.4659    4.9192    4.1834     3.2869    2.2641    1.1542         0   -1.1542   -2.2641   -3.2869   -4.1834   -4.9192      -5.4659   -5.8026   -5.9163   -5.8026   -5.4659   -4.9192   -4.1834   -3.2869   -2.2641     -1.1542    0.0000;
%            -2.1094   -2.0689   -1.9488   -1.7539   -1.4916   -1.1719   -0.8072   -0.4115         0      0.4115    0.8072    1.1719    1.4916    1.7539    1.9488    2.0689    2.1094    2.0689      1.9488    1.7539    1.4916    1.1719    0.8072    0.4115    0.0000   -0.4115   -0.8072    -1.1719   -1.4916   -1.7539   -1.9488   -2.0689    5.9163    5.8026    5.4659    4.9192          4.1834    3.2869    2.2641    1.1542    0.0000   -1.1542   -2.2641   -3.2869   -4.1834      -4.9192   -5.4659   -5.8026   -5.9163   -5.8026   -5.4659   -4.9192   -4.1834   -3.2869     -2.2641   -1.1542    0.0000    1.1542    2.2641    3.2869    4.1834    4.9192    5.4659      5.8026   -0.0000;
%            -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392     -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392     -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392   -5.0392     -5.0392   -5.0392   -5.0392   -5.0392   -5.0392  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346  -14.7346    -14.7346         0];
        subclassToClassMapping = [ones(1,8) 2*ones(1,8) 3]
        XterrainMesh
        YterrainMesh
        Post = surf([],[],[]);
    end
    methods
        function obj = Fusion(xTerrainMax,yTerrainMax,p)      %add value for blank Landmark
            
            % Add library paths
            libPath = p;     % path to MatlabLib folder; % param
            addpath(genpath(libPath));

            % Define MMS parameters
            % number of words in the dictionary
            dictionarySize = 3; %#ok<NASGU>
            
            % Define husion parameters
            % Use true if we want to visualize the output pdf for debugging
            isPlotOutputPdf = false; % param

            % Define terrain grid parameters
            xTerrainMin = 0; %-20;  % meters    % param
            yTerrainMin = 0; %-10;  % meters    % param
            xGridResolution = 0.5;  % meters    % param
            yGridResolution = xGridResolution;  % meters 

            % Setup terrain grid 
            xGrid = xTerrainMin:xGridResolution:xTerrainMax;
            yGrid = yTerrainMin:yGridResolution:yTerrainMax;
            [obj.XterrainMesh, obj.YterrainMesh] = meshgrid(xGrid, yGrid);
            
            % Define prior distribution p(X) as a uniform Gaussian mixture

            % Define uniform GM parameters
            dXmixand = 7;   %2%LOW_RES 
            dYmixand = 7;   %2%LOW_RES 
            sdMixand = 15;  %5%LOW_RES 
            priorTerrainMargin = 20;

            XYmesh = [obj.XterrainMesh(:), obj.YterrainMesh(:)]; % (:) unrolls all columns of XterrainMesh into a single column vector

            % Generate uniform GM
            priorGMdistributionXY = GenerateUniformGMpX(isPlotOutputPdf, dXmixand,dYmixand,sdMixand,priorTerrainMargin, ...
                                                    xTerrainMin,xTerrainMax,yTerrainMin,yTerrainMax, ...
                                                    XYmesh,obj.XterrainMesh,obj.YterrainMesh);

            % The initial log(p(X)) input to husion                                    
            obj.Prior = log(priorGMdistributionXY);
            
            % Visualize husion output pdf
            figure(1)
            obj.Post = surf(obj.XterrainMesh,obj.YterrainMesh,exp(obj.Prior'),'EdgeColor','none','FaceAlpha',0.5);
            view(2)
            title('Prior','fontsize',15)
            xlabel('x_0 (m)','fontsize',15)
            ylabel('x_1 (m)','fontsize',15)
            colorbar
            colormap(jet)
            hold on
        end
        
        function updateFusion(obj,D,xl_in)
            
            %Define human inputs
            disp('1="Near" 2="Far" or 3="At"')
            %D = input('value of D :'); % 1="Near" 2="Far" or 3="At" 
            %xl_in = input('Location:');

            % The initial log(p(X)) input to husion                                    
            lnpX = obj.Prior;

            % Calculate p(D|X,xl_in) for the input word at current Husion time step
            % % TODO: There might/will be discretization error up to the size of the grid resolution [resolutionX,resolutionY]
            lnpDgivenXandXl_input = lnpDGivenXfromWeights_singleD(obj.weightMatrix, obj.subclassToClassMapping,obj.XterrainMesh,obj.YterrainMesh, xl_in,D);

            % Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
            % ln p(D,X)
            lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
            lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));

            % ln p(D)
            lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );

            % ln p(X|D)
            lnpXgivenD = lnpDandXgivenXl - lnpD;
            
            obj.Prior = lnpXgivenD;
            
            %Visualize husion output pdf
            set(obj.Post,'XData',obj.XterrainMesh,'YData',obj.YterrainMesh,'ZData',exp(lnpXgivenD'),'EdgeColor','none');
            view(2)
%             title(['Posterior Given Human Measurement p(x|{\zeta^{ HUMAN}}); D = ' num2str(D) ', x_{l} = [' num2str(xl_in(1)) ' ' num2str(xl_in(2)) ']^T '],'fontsize',15)
%             xlabel('x_0 (m)','fontsize',15)
%             ylabel('x_1 (m)','fontsize',15)
        end
        
        function BotFusion(obj,Li)
            % The initial log(p(X)) input to husion
            lnpX = obj.Prior;

            lnpDgivenXandXl_input = log(Li');

            % Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
            % ln p(D,X)
            lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
            lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));

            % ln p(D)
            lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );

            % ln p(X|D)
            lnpXgivenD = lnpDandXgivenXl - lnpD;
            
            obj.Prior = lnpXgivenD;
            
            %Visualize husion output pdf
            set(obj.Post,'XData',obj.XterrainMesh,'YData',obj.YterrainMesh,'ZData',exp(lnpXgivenD'),'EdgeColor','none','FaceAlpha',0.5);
            view(2)
%             title('Robot Posterior','fontsize',15)
%             xlabel('x_0 (m)','fontsize',15)
%             ylabel('x_1 (m)','fontsize',15)
        end
        
        function slowFusion(obj,c)
            % The initial log(p(X)) input to husion
            lnpX = obj.Prior;

            % Calculate p(D|X,xl_in) for the input word at current Husion time step
            % % TODO: There might/will be discretization error up to the size of the grid resolution [resolutionX,resolutionY]
            lnpDgivenXandXl_input = lnpDGivenXfromWeights_singleD(obj.weightMatrix, obj.subclassToClassMapping,obj.XterrainMesh,obj.YterrainMesh, c(2:3),c(1));


            % Husion calcuation: p(X|D) = p(D|X)p(X)/p(D) using log of sum trick to prevent underflow
            % ln p(D,X)
            lnpDandXgivenXl = lnpDgivenXandXl_input + lnpX;
            lnpDandXgivenXl_max = max(max(lnpDandXgivenXl));

            % ln p(D)
            lnpD = lnpDandXgivenXl_max + log( sum(sum( exp(lnpDandXgivenXl-lnpDandXgivenXl_max) )) );

            % ln p(X|D)
            lnpXgivenD = lnpDandXgivenXl - lnpD;
            
            obj.Prior = lnpXgivenD;
            
            %Visualize husion output pdf
            set(obj.Post,'XData',obj.XterrainMesh,'YData',obj.YterrainMesh,'ZData',exp(lnpXgivenD'),'EdgeColor','none','FaceAlpha',0.5);
            view(2)
        end
    end
end