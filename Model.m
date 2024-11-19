classdef Model < handle
    properties
        currentPose
        v = 1;  % linear velocity
        w = 0;  % angular velocity
    end
    
    methods
        function obj = Model(initialPose)
            obj.currentPose = initialPose; % [x, y]
        end

        function move(obj,action) 

            if action == 1      % North
                theta = pi/2;
            elseif action == 2  % East
                theta = 0;
            elseif action == 3  % West
                theta = pi;
            elseif action == 4  % South
                theta = -pi/2;
    
            end
            
            
            obj.currentPose(1) = obj.currentPose(1) + obj.v * cos(theta) * 1;  % Update x
            obj.currentPose(2) = obj.currentPose(2) + obj.v * sin(theta) * 1;  % Update y

        end


    end

end