classdef mazeMap < handle
    properties
        map
        start
        goal
    end
    
    methods
        function obj = mazeMap()
            p = [ 0 0 0 0 0;
                  0 0 0 0 0;
                  0 0 1 1 1;
                  0 0 1 0 0;
                  0 0 0 0 0];
        
            obj.map = p;
            obj.reset();
        end
        function reset(obj)
            obj.start = [1 1];
            obj.goal = [5 5];
        end
    end
end