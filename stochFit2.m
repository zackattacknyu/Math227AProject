%here is the Scandanavian wolf data
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


%before and after 1991, mean
meanWolvesPre1991 = meanTotalWolves(1:11);
meanWolvesPost1991 = meanTotalWolves(11:end);

%%

%Pre 1991 Data
numSteps = 100;
numTraj = 400; 
%rValue = 0.0789; %from exponential fit model
%deathRate = 0.25; 
%birthRate = rValue+deathRate; %calculate the birth rate so that b-d=r

%make note of these values. KEEP THEM. 
birthRate = 0.060;
deathRate = 0.045;

initNum = floor(rand(numTraj,1)*5 + 2); 

[times,numWolves] = runStochBirthDeath(birthRate,deathRate,initNum,numSteps,numTraj);

tVals = 0:10;
yInds = 1:11;

figure
hold on
stairs(times',numWolves')
plot(tVals,minTotalWolves(yInds),'r','LineWidth',2)
plot(tVals,meanTotalWolves(yInds),'r--','LineWidth',2)
plot(tVals,maxTotalWolves(yInds),'r','LineWidth',2)
axis([0 10 0 inf]);
%%
%Post 1991 Data using pre-1991 info

tVals = 0:20;
yInds = 1:21;

figure
hold on
stairs(times',numWolves')
plot(tVals,minTotalWolves(yInds),'r','LineWidth',2)
plot(tVals,meanTotalWolves(yInds),'r--','LineWidth',2)
plot(tVals,maxTotalWolves(yInds),'r','LineWidth',2)
axis([0 20 0 inf]);
%%

%now include immigration in post-1991 data
immRate = 0.5;

[times2,numWolves2] = runStochBirthDeathImmigration(birthRate,deathRate,immRate,...
    initNum,numSteps,numTraj);

tVals = 0:20;
yInds = 1:21;
figure
hold on
stairs(times2',numWolves2')
plot(tVals,minTotalWolves(yInds),'r','LineWidth',2)
plot(tVals,meanTotalWolves(yInds),'r--','LineWidth',2)
plot(tVals,maxTotalWolves(yInds),'r','LineWidth',2)
axis([0 20 0 inf]);