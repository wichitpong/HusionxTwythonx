classdef Camera < handle
    %Camera Summary of this class goes here
    
    properties
        AOV = 30    % angle of view
        Range = 30  % detection range
        Count
        Xcam = 0    % default position of camera
        Ycam = 0    % default position of camera
        Theta = 0   % default position of camera
        Orient      % triangle that show camera view
    end

    methods
        function obj = Camera(fre)
            %Plot triangle to show camera's angle of view, for more information read in Equation.docx
            obj.Orient = line([obj.Xcam obj.Xcam+obj.Range*cosd(obj.Theta)+obj.Range*tand(obj.AOV/2)*cosd(90-obj.Theta) obj.Xcam+obj.Range*cosd(obj.Theta)-obj.Range*tand(obj.AOV/2)*cosd(90-obj.Theta) obj.Xcam],...
                              [obj.Ycam obj.Ycam+obj.Range*sind(obj.Theta)-obj.Range*tand(obj.AOV/2)*sind(90-obj.Theta) obj.Ycam+obj.Range*sind(obj.Theta)+obj.Range*tand(obj.AOV/2)*sind(90-obj.Theta) obj.Ycam],...
                              [1.1 1.1 1.1 1.1],'color', 'green', 'linewidth', 2);
            obj.Count = fre;
        end
    end
end

