%{
This runs the stochastic models for the Scandinavian wolves
%}

%Scandanavian wolf data
winterYearStart = 1980:2000;
winterYearEnd = winterYearStart+1;
minTotalWolves = ...
    [2 3 3 8 6 7 5 6 10 8 8 16 19 ...
    16 29 34 41 50 62 67 87];
maxTotalWolves = ...
    [6 3 3 8 6 7 5 6 10 8 8 18 22 ...
    30 39 45 57 72 78 81 97];

%this expression obtains most of the mean values
meanTotalWolves = floor((maxTotalWolves+minTotalWolves)./2);
meanTotalWolves(14)=28; %only mean value to be input manually

numSteps = 200;
numTraj = 400; 

%{
This does the simulation for pre-1991 Data
%}

%birth and death rate values
birthRate = 0.075;
deathRate = 0.045;

%initial number of wolves in winter 1980-1981
initNum = floor(rand(numTraj,1)*5 + 2); 

%run the simulation
[times,numWolves] = runStochBirthDeath(birthRate,deathRate,initNum,numSteps,numTraj);

%Display the pre-1991 results for all years
tVals = 0:20;
yInds = 1:21;
figure
hold on
stairs(times',numWolves')
plot(tVals,minTotalWolves(yInds),'k','LineWidth',3)
plot(tVals,meanTotalWolves(yInds),'k--','LineWidth',3)
plot(tVals,maxTotalWolves(yInds),'k','LineWidth',3)
xlabel('Years since winter 1980-1981');
ylabel('Number of Wolves');
axis([0 20 0 inf]);


%Display the pre-1991 results for first 10 years
tVals = 0:10;
yInds = 1:11;
figure
hold on
stairs(times',numWolves')
plot(tVals,minTotalWolves(yInds),'k','LineWidth',3)
plot(tVals,meanTotalWolves(yInds),'k--','LineWidth',3)
plot(tVals,maxTotalWolves(yInds),'k','LineWidth',3)
xlabel('Years since winter 1980-1981');
ylabel('Number of Wolves');
axis([0 10 0 inf]);

%{
This runs the simulation starting from
Winter 1990-1991 using birth and death
from pre-1991 and including immigration
%}

%immigration rate
immRate = 2.5;

%number of wolves in winter 1990-1991
initNum=8;

%run the simulation
[times2,numWolves2] = runStochBirthDeathImmigration(birthRate,deathRate,immRate,...
    initNum,numSteps,numTraj);

%display the results
tVals = 0:10;
yInds = 11:21;
figure
hold on
stairs(times2',numWolves2')
plot(tVals,minTotalWolves(yInds),'k','LineWidth',3)
plot(tVals,meanTotalWolves(yInds),'k--','LineWidth',3)
plot(tVals,maxTotalWolves(yInds),'k','LineWidth',3)
xlabel('Years since Winter 1990-1991');
ylabel('Number of Wolves');
axis([0 10 0 inf]);


%{
Run the simulation for wolf data after 1991
%}

%new birth and death rate
deathRate=0.01;
birthRate=0.21;

%number of wolves in winter 1991-1992
initNum = 18.*ones(numTraj,1); 

%run the simulation
[times,numWolves] = runStochBirthDeath(birthRate,deathRate,initNum,numSteps,numTraj);

%display the results
tVals = 0:9;
yInds = 12:21;
figure
hold on
stairs(times',numWolves')
plot(tVals,minTotalWolves(yInds),'k','LineWidth',3)
plot(tVals,meanTotalWolves(yInds),'k--','LineWidth',3)
plot(tVals,maxTotalWolves(yInds),'k','LineWidth',3)
xlabel('Time Since Winter 1991-1992');
ylabel('Number of Wolves');
axis([0 10 0 maxTotalWolves(end)]);