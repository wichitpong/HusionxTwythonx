classdef Map < handle
    
    properties
        Fig                 %set default map
        IniPos = [0 0]      %set default start point
        Width               %width of map
        Height              %height of map
        LandmarkList = containers.Map('KeyType','char','ValueType','any')
    end
    
    methods
        function obj = Map(w,h)
            obj.Width = w;
            obj.Height = h;
        end
        
        function loadLandmark(obj,l)
            obj.LandmarkList(l.Name) = l;
            l.plotLandmark;
        end
    end
end