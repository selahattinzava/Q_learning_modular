clc; clear;

GW = mazeMap();
myenv = Environment();
mynet = CustomNetwork(myenv);
agent = CustomAgent(myenv, mynet);

validateEnvironment(myenv);

agent.train();

Q = agent.agent.getLearnableParameters;
disp(Q.Critic{:});

% myenv.reset();
% agent.sim()
