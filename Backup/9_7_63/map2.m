classdef map2 < handle
    properties
        fig                                 %set default map
        start = [0,0]                       %set default start point
        width                               %width of map
        height                              %height of map
    end
    methods
%         function m = map(file)             %create map from picture
%            image     = imread(file);
%            grayimage = rgb2gray(image);
%            bwimage   = grayimage < 0.5; 
%            m.fig     = binaryOccupancyMap(bwimage);
%         end
        function m = map(h,w)
            m.height = h;
            m.width = w;
        end
%         function h = get.height(map)
%             h = map.fig.GridSize(1);
%         end
%         function w = get.width(map)
%             w = map.fig.GridSize(2);
%         end
    end
end