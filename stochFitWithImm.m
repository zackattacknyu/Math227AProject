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
numSteps = 50;
numTraj = 400; 
%rValue = 0.0789; %from exponential fit model
%deathRate = 0.25; 
%birthRate = rValue+deathRate; %calculate the birth rate so that b-d=r

%make note of these values. KEEP THEM. 
birthRate = 0.060;
deathRate = 0.045;

immRate = 0.1;

initNum = floor(rand(numTraj,1)*5 + 2); 

[times,numWolves] = runStochBirthDeathImmigration(birthRate,deathRate,immRate,...
    initNum,numSteps,numTraj);

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
%Post 1991 Data
numSteps = 200;
numTraj = 400; 

%rValue = 0.1704; %from exponential fit model
%deathRate = 0.2; %TO CHOOSE OURSELVES
%birthRate = rValue+deathRate; %calculate the birth rate so that b-d=r

%make note of these valus. KEEP THEM. 
deathRate=0.03;
birthRate=0.23;

immRate = -0.2;

initNum = 18.*ones(numTraj,1); %min, max, and mean were 8 in 1990-1991

[times,numWolves] = runStochBirthDeathImmigration(birthRate,deathRate,immRate,...
    initNum,numSteps,numTraj);

tVals = 0:9;
yInds = 12:21;

figure
hold on
stairs(times',numWolves')
plot(tVals,minTotalWolves(yInds),'r','LineWidth',2)
plot(tVals,meanTotalWolves(yInds),'r--','LineWidth',2)
plot(tVals,maxTotalWolves(yInds),'r','LineWidth',2)
axis([0 10 0 maxTotalWolves(end)]);