clc; clear;

GW = mazeMap();
GW.show();


goalState = [5, 5];
env = Environment();

net = CustomNetwork(obsInfo,actInfo);
agent = CustomAgent();

trainingStats = agent.train(env, net)

