clc; clear;

GW = mazeMap();
GW.show();
obsInfo = rlFiniteSetSpec(1:25);
obsInfo.Name = 'Agent States';

actInfo = rlFiniteSetSpec(1:4);
actInfo.Name = 'Agent Action';

goalState = [5, 5];
env = Environment();

net = CustomNetwork(obsInfo,actInfo);
agent = CustomAgent();

trainingStats = train(agent, env, net)

