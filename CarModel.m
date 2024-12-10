classdef CarModel < handle
    properties
        currentPosition
        v = 1;  % linear velocity
        w = 0;  % angular velocity
        ts = 1;
        rotation
        initialposition = [1 1]
        initialorientation = 0;
    end
    
    methods
        function obj = CarModel(initposition)
            obj.initialposition = initposition;
            obj.reset();
        end

        function move(obj,action) 

            if action == 1      % East
                theta = 180;
            elseif action == 2  % South
                theta = 0;
            elseif action == 3  % North
                theta = 90;
            elseif action == 4  % West
                theta = -90;
            end
            obj.rotation = theta;
            obj.currentPosition(1) = obj.currentPosition(1) + obj.v * cosd(theta) * obj.ts;  % Update x
            obj.currentPosition(2) = obj.currentPosition(2) + obj.v * sind(theta) * obj.ts;  % Update y

        end

        function reset(obj)
            obj.currentPosition = obj.initialposition;
        end


    end

end