classdef Landmark < handle
    properties
        Id          {mustBeInteger}
        Name
        Type
        Vertices
        Polygon
    end
    properties      (Dependent)
        Centroid
    end
    methods
        function addinfo(obj)                                       %add value for blank Landmark
            obj.Id = input('add Id: ');
            obj.Name = input('add Name: ');
            obj.Type = input('add Type: ');
            obj.Vertices = input('add Vertices: ');
        end
        function set.Name(obj,name)                                 %Name must be single row, charr
            if ischar(name) && ismatrix(name) && size(name,1)==1
                obj.Name = name;
            else
                error('Invaild Name');
            end
        end
        function set.Type(obj,type)                                 %control allowable Type value
           	possType = {'wall','building','furniture'};
          	switch type
             	case possType
                   	obj.Type = type;
                otherwise
                   	error('Invaild type');
            end
        end
        function b = get.Polygon(obj)
            b = polyshape(obj.Vertices);
        end        
        function c = get.Centroid(obj)
            [cx, cy] = centroid(obj.Polygon);
            c = [cx, cy];
        end
        function plotlandmark(~,Landmarks)
            figure(2)
            plot(Landmarks.Polygon)
            hold on
        end
    end
end