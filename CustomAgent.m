classdef CustomAgent < handle
    properties
        AgentOptions
        TrainingOptions
    end

    methods
        function obj = CustomAgent()
            obj.AgentOptions = rlQAgentOptions(...
                'EpsilonGreedyExploration', struct('Epsilon', 0.9), ...
                'DiscountFactor', 0.99);

            obj.TrainingOptions = rlTrainingOptions(...
                'MaxEpisodes', 400, ...
                'MaxStepsPerEpisode', 50, ...
                'StopTrainingCriteria', "AverageReward", ...
                'StopTrainingValue', 10, ...
                'ScoreAveragingWindowLength', 10);
        end


        function trainingStats = train(agent, env, net)
            maxEpisodes = agent.TrainingOptions.MaxEpisodes;
            maxSteps = agent.TrainingOptions.MaxStepsPerEpisode;
            epsilon = agent.AgentOptions.EpsilonGreedyExploration.Epsilon;
            alpha = 0.1;
            gamma = agent.AgentOptions.DiscountFactor;
        
            trainingStats = struct('EpisodeReward', zeros(maxEpisodes, 1));
        
            for episode = 1:maxEpisodes
                state = reset(env);
                isDone = false;
                totalReward = 0;
        
                for step = 1:maxSteps
                    if isDone 
                        break; 
                    end
                    
                    action = net.selectAction(state, epsilon);
                    [nextState, reward, isDone, ~] = step(env, action);
                    net.updateQTable(state, action, reward, nextState, alpha, gamma);
                    state = nextState;
                    totalReward = totalReward + reward;
                end
        
                trainingStats.EpisodeReward(episode) = totalReward;
                disp(['Episode ', num2str(episode), ': Total Reward = ', num2str(totalReward)]);
            end
        end
    end
end


