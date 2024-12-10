classdef CustomAgent < handle
    properties
        env
        net
        agent
        AgentOptions
        TrainingOptions
        trainingStats
    end

    methods
        function obj = CustomAgent(env, net)
            obj.env = env;
            obj.net = net;

            AgentOptions = rlQAgentOptions;
            AgentOptions.DiscountFactor = 1;
            AgentOptions.EpsilonGreedyExploration.Epsilon = 0.9;
            AgentOptions.CriticOptimizerOptions.LearnRate = 0.01;
            obj.agent = rlQAgent(obj.net.Critic, AgentOptions);

            obj.TrainingOptions = rlTrainingOptions;
            obj.TrainingOptions.MaxStepsPerEpisode = 50;
            obj.TrainingOptions.MaxEpisodes = 500;
            obj.TrainingOptions.StopTrainingCriteria = "None";
            obj.TrainingOptions.StopTrainingValue = "None";
            obj.TrainingOptions.ScoreAveragingWindowLength = 30;
        end

        function train(obj)

            obj.trainingStats = train(obj.agent, obj.env, obj.TrainingOptions);
        end

    end
end


