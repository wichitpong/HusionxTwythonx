classdef Robot6<handle
    properties
          velocity = 0;                         
          position = [0 0];
          angle=0;
          xl
          yl
    end
    methods
        function Runn(obj)
            % This demo performs one step of human input update, calling functions from
            % MatlabLib library (path = '..\' for windows)
            % 
            %%
            % close all
            % clear all
            % clc

            %% Add library paths
            libPath = 'G:\My Drive\เรียน\year 3\ฝึกงาน\ASL\MatlabLib\MatlabLib'; % path to MatlabLib folder; % param
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
            D = 1; % 1="Near" 2="Far" or 3="At"   % param
            xl_in = [50 15]; % param

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
            pD = exp(lnpD);

            % ln p(X|D)
            lnpXgivenD = lnpDandXgivenXl - lnpD;


            %% Visualize husion output pdf

            figure(2) %%%%figure(2)
            %Husi=surf(XterrainMesh,YterrainMesh, exp(lnpXgivenD'),'EdgeColor','none')   
            Husi=surf([],[],[]) 
            view(2)
            hold on
            title(['Posterior Given Human Measurement p(x|{\zeta^{ HUMAN}}); D = ' num2str(D) ', x_{l} = [' num2str(xl_in(1)) ' ' num2str(xl_in(2)) ']^T '],'fontsize',15)
            xlabel('x_0 (m)','fontsize',15)
            ylabel('x_1 (m)','fontsize',15)
            % xlabel('$x_0$ (m)','fontsize',12,'interpreter','latex')
            % ylabel('$x_1$ (m)','fontsize',12,'interpreter','latex')
            colorbar    
            colormap(jet)
            
            
            
    %=========================================================================================================
            set( gcf,'WindowKeyPressFcn',  @keyboard_down,'CloseRequestFcn', @close_window, 'WindowKeyReleaseFcn', @keyboard_up)
            set( gca,'color', 'white','xlim', [0, 200],'ylim', [0, 100])
             robot=line(obj.position(1), obj.position(2),'marker','o');
             hold(gca,'on')
             orient = surf([],[],[]) ;
             grid off 
                shading interp
                colormap(jet(50))
                view(2)
              program_on = 1;
     
              while program_on         
                userdataStore=[obj.velocity obj.angle obj.position];
                %pause(0.001);
                
                vel = [userdataStore(1)*cosd(userdataStore(2)),userdataStore(1)*sind(userdataStore(2))];
                pos = userdataStore(3:4);
                new_position = pos + vel;
                if (new_position(1) > 200 || new_position(2) > 100 || new_position(1) < 0 || new_position(2) < 0)
                    new_position = pos;
                end
                obj.position = new_position;
                
                set(robot, 'XData', new_position(1), 'YData', new_position(2));
                
%                 x=[new_position(1) new_position(1)+10*cosd(userdataStore(2))+10*tand(35)*cosd(90-userdataStore(2)) new_position(1)+10*cosd(userdataStore(2))-10*tand(35)*cosd(90-userdataStore(2))];
%                 y=[new_position(2) new_position(2)+10*sind(userdataStore(2))-10*tand(35)*sind(90-userdataStore(2)) new_position(2)+10*sind(userdataStore(2))+10*tand(35)*sind(90-userdataStore(2))];
%                 z=[100 0 0];
%                 xv = linspace(min(x), max(x), 100);
%                 yv = linspace(min(y), max(y), 100);
%                 [X,Y] = meshgrid(xv, yv);
%                  Z = griddata(x,y,z,X,Y);
                
%                 set(orient,'XData',X,'YData',Y,'ZData',Z)
%                 drawnow
%                 pause(0.01)
                
                set(Husi,'XData',XterrainMesh,'YData',YterrainMesh,'ZData',exp(lnpXgivenD'))
                drawnow
                pause(0.01)
               
              end
             delete(gcf);
              
             function close_window(~,~)
                program_on = 0;
             end
             
             function keyboard_down(~, event)
                switch event.Key
                    case 'downarrow'
                        obj.velocity = -1;
                    case 'uparrow'
                        obj.velocity = 1;    
                    case 'leftarrow'
                        obj.angle = obj.angle + 6;
                    case 'rightarrow'
                        obj.angle = obj.angle - 6;
                    otherwise
                        disp('unknown key');
                end
             end
             
            function keyboard_up(~,~)
                obj.velocity = 0;
            end
            
        end
        
    end
end

%============================

          