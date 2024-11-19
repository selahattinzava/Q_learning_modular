classdef Environment < rl.env.MATLABEnvironment
    properties
        RewardForReach = 10
        RewardForStep = -1
        State 
        IsDone = false
        goalState = [5 5]
        InitialObservation
        Model
    end

    methods
        function obj = Environment()
            obsInfo = rlFiniteSetSpec(1:25);
            obsInfo.Name = 'Agent States';
            
            actInfo = rlFiniteSetSpec(1:4);
            actInfo.Name = 'Agent Action';
            
            obj = obj@rl.env.MATLABEnvironment(obsInfo,actInfo);
        end

        function obj = reset(obj)
            x = 1; y = 1;
            obj.InitialObservation = [x y];
        end

        
        function [Observation,Reward,IsDone] = step(obj,action)
            obj.Model.move(action);
            newState = obj.Model.currentPose;

            if obj.isWallHit(newState)
                reset(obj);
            else
                obj.State = newState;
                if isequal(newState, obj.goalState)
                    obj.IsDone = true;
                end
                Observation = obj.State;
            end

            Reward = getReward(obj);
            IsDone = obj.IsDone;

        end
        

        function Reward = getReward(obj)
            if ~obj.IsDone
                Reward = obj.RewardForReach;
            else
                Reward = obj.RewardForStep;
            end
        end

        function hit = isWallHit(obj, newState)
            if obj.MazeMap.map(newState(1), newState(2)) == 1
                hit = true;
            else
                hit = false;
            end
        end
    end
end
