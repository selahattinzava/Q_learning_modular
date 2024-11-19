classdef mazeMap < handle
    properties
        map
    end
    
    methods
        function obj = mazeMap()
            p = [ 0 0 0 0 0;
                  0 0 0 0 0;
                  0 0 1 1 1;
                  0 0 1 0 0;
                  0 0 0 0 0];
        
            obj.map = binaryOccupancyMap(p);
        end
        function show(obj)
            show(obj.map);
        end
    end
end