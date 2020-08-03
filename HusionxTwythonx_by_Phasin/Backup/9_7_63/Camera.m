classdef Camera < handle
    %CAMERA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Angle_of_view = 30
        Detection_range = 30
        frequency
        Xcam = 0
        Ycam = 0
        theta = 0
        orient
    end
    
    properties (Dependent)
        
    end
    
    methods
        function cam(obj)
            obj.orient = line([obj.Xcam obj.Xcam+obj.Detection_range*cosd(obj.theta)+obj.Detection_range*tand(obj.Angle_of_view/2)*cosd(90-obj.theta) obj.Xcam+obj.Detection_range*cosd(obj.theta)-obj.Detection_range*tand(obj.Angle_of_view/2)*cosd(90-obj.theta) obj.Xcam],...
                              [obj.Ycam obj.Ycam+obj.Detection_range*sind(obj.theta)-obj.Detection_range*tand(obj.Angle_of_view/2)*sind(90-obj.theta) obj.Ycam+obj.Detection_range*sind(obj.theta)+obj.Detection_range*tand(obj.Angle_of_view/2)*sind(90-obj.theta) obj.Ycam],...
                              [100 100 100 100],'color', 'green', 'linewidth', 2);
        end
    end
end

