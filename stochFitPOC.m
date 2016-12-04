%This is the Proof of Concept for the stochastic modelling code
% it re-creates the Figure 5.9 from Section 5.6.2 of the de Vries book 

birthRate = 0.333;
deathRate = 0.3;

numSteps = 200;
numTraj = 50; 

initNum = 10.*ones(numTraj,1);

[times,numWolves] = runStochBirthDeath(birthRate,deathRate,initNum,numSteps,numTraj);

figure
stairs(times',numWolves')
axis([0 9 0 inf]);