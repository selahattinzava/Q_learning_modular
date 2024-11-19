classdef CustomAgent < handle
    properties
        AgentOptions
        TrainingOptions
    end

    methods
        function obj = CustomAgent()
            epsilonGreedy = rl.option.EpsilonGreedyExploration("Epsilon", 0.9);
            obj.AgentOptions = rlQAgentOptions('EpsilonGreedyExploration', epsilonGreedy,'DiscountFactor', 0.99);

            obj.TrainingOptions = rlTrainingOptions(...
                'MaxEpisodes', 400, ...
                'MaxStepsPerEpisode', 50, ...
                'StopTrainingCriteria', "AverageReward", ...
                'StopTrainingValue', 10, ...
                'ScoreAveragingWindowLength', 10);
        end


        function trainingStats = train(obj,env, net)
            maxEpisodes = obj.TrainingOptions.MaxEpisodes;
            maxSteps = obj.TrainingOptions.MaxStepsPerEpisode;
            epsilon = obj.AgentOptions.EpsilonGreedyExploration.Epsilon;
            alpha = 0.1;
            gamma = obj.AgentOptions.DiscountFactor;
        
            trainingStats = struct('EpisodeReward', zeros(maxEpisodes, 1));
        
            for episode = 1:maxEpisodes
                state = env.reset();
                isDone = false;
                totalReward = 0;
        
                for step = 1:maxSteps
                    if isDone 
                        break; 
                    end
                    
                    action = net.selectAction(state, epsilon);
                    [nextState, reward, isDone] = env.step(action);
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


