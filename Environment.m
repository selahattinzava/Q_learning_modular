classdef Environment < rl.env.MATLABEnvironment
    properties
        RewardForReach = 10
        RewardForStep = -1
        RewardForJump = 5
        RewardForHit = 0
        State 
        IsDone = false
        goalState = [5 5]
        jumpState = [2 4]
        checkJump
        checkGoal
        checkHit
        Car
        mazeMap
    end  

    methods
        function obj = Environment()
            obsInfo = rlFiniteSetSpec(1:25);
            obsInfo.Name = 'Agent States';
            
            actInfo = rlFiniteSetSpec(1:4);
            actInfo.Name = 'Agent Actions';
            obj = obj@rl.env.MATLABEnvironment(obsInfo,actInfo);

            obj.mazeMap = mazeMap();
            obj.Car = CarModel(obj.mazeMap.start);

        end

        function InitialObservation = reset(obj)
            x = 2; y = 1;
            obj.State = [x y];
            obj.IsDone = false;
            obj.checkJump = false;
            obj.checkGoal = false;
            obj.checkHit = false;
            InitialObservation = obj.ConvertStateToIndex(obj.State);
        end

        function [Observation,Reward,IsDone] = step(obj,action)

            obj.Car.move(action);
            newState = obj.Car.currentPosition;
 
            if obj.isWallHit(newState)
                obj.IsDone = true;
                obj.checkHit = true;
            elseif obj.shouldJump(newState)
                obj.State = [4 4];
                obj.checkJump = true;
            elseif obj.isGoalReach(newState)
                obj.checkGoal = true;
                obj.State = newState;
                obj.IsDone = true;
            else
                obj.State = newState;
            end
            
            Observation = obj.ConvertStateToIndex(obj.State);
            Reward = getReward(obj);
            IsDone = obj.IsDone;

        end
        
        function Reward = getReward(obj)
            if obj.checkGoal 
                Reward = obj.RewardForReach;
            elseif obj.checkJump
                Reward = obj.RewardForJump;
            elseif obj.checkHit
                Reward = obj.RewardForHit;
            else
                Reward = obj.RewardForStep;
            end
        end


        function hit = isWallHit(obj, State)
            if State(1) < 1 || State(1) > 5 || State(2) < 1 || State(2) > 5
                hit = true; % Out of bounds
            else
                hit = obj.mazeMap.map(State(1), State(2)) == 1; % wall hit
            end
        end

        function jump = shouldJump(obj, State)
            jump = isequal(State, obj.jumpState);
        end

        function goal = isGoalReach(obj, State)
            goal = isequal(State, obj.goalState);
        end

        function index = ConvertStateToIndex(~, State)
            index = State(1) + (State(2) - 1) * 5;
        end
    end
end
