classdef Landmark < handle
    % create landmark in this class
    
    properties
        ID          {mustBeInteger}
        Name
        Type
        Vertices    
        Centroid
    end
    
    methods
        function obj = Landmark(id,name,type,vertices)      
            %add value for blank Landmark
            obj.ID = id;
            obj.Name = name;
            obj.Type = type;
            obj.Vertices = vertices;
        end
        
        function set.Name(obj,name)                         
            %Name must be single row, charr
            if ischar(name) && ismatrix(name) && size(name,1)==1
                obj.Name = name;
            else
                error('Invaild Name');
            end
        end
        
        function set.Type(obj,type)                         
            %control allowable Type value
           	possType = {'wall','building','furniture'};
          	switch type
             	case possType
                   	obj.Type = type;
                otherwise
                   	error('Invaild type');
            end
        end
        
        function plotLandmark(obj)
            %show landmark in map
            figure(1);
            fill3(obj.Vertices(:,1)',...
                  obj.Vertices(:,2)',...
                  ones(1,length(obj.Vertices(:,1)'))*1.2,'w')
        end
    end
end