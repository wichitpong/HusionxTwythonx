classdef Simulator < handle
    % others class work together in this class
    
	properties
        Robot
    	Map
    end
    
  	methods
        function obj = Simulator(m,l,r)
            obj.loadMap(m);
            obj.loadRobot(r,l);
        end
        
        function loadMap(obj,m)
            obj.Map = m;
            figure(1);
            % set axis limit            
            gca;
            xlim([0 m.Width]);
            ylim([0 m.Height]);
            zlim([0 1.3]);
        end
        
        function loadRobot(obj,r,l)
            obj.Robot = r;
            obj.Robot.Xlim = obj.Map.Width;
            obj.Robot.Ylim = obj.Map.Height;
            obj.Robot.BotFus = l;
            obj.Robot.runRobot;
        end
    end
 end