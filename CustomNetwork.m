classdef CustomNetwork < handle
    properties
        Qtable  
        Critic   
        obsInfo
        actInfo
        Options
    end

    methods
        function obj = CustomNetwork(env)
            obj.obsInfo = env.getObservationInfo(); 
            obj.actInfo = env.getActionInfo();
            obj.Qtable = rlTable(obj.obsInfo, obj.actInfo);  % obs and act infos must be rlFiniteSetSpec
            obj.Critic = rlQValueFunction(obj.Qtable, obj.obsInfo, obj.actInfo); 
        end
    end
end
