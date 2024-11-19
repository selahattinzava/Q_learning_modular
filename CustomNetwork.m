classdef CustomNetwork < handle
    properties
        Qtable  
        Critic  % rlQValueFunction 
    end

    methods
        function obj = CustomNetwork(obsInfo, actInfo)
            obj.Qtable = rlTable(obsInfo, actInfo); 
            obj.Critic = rlQValueFunction(obj.Qtable, obsInfo, actInfo); 
        end

        function action = selectAction(obj, state, epsilon)
            % eepsilon-greedy 
            if rand < epsilon
                action = randi(obj.Critic.ActionInfo.Dimension(1)); % random 
            else
                qValues = getValue(obj.Critic, state); 
                [~, action] = max(qValues); % selecting action with maximum Qvalue
            end
        end

        function updateQTable(obj, state, action, reward, nextState, alpha, gamma)
            maxQNext = max(getValue(obj.Critic, nextState)); % Maximum Qvalue for next state
            currentQ = getValue(obj.Critic, state, action); % Current Qvalue
            updatedQ = currentQ + alpha * (reward + gamma * maxQNext - currentQ); % Q_learning 
            obj.Qtable.Table(state, action) = updatedQ; % updating 
        end
    end
end
