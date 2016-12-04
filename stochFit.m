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

deltaNbyState = [-1 1];
numSteps = 50;
numTraj = 50; 
times = zeros(numTraj,numSteps); %time point
numWolves = zeros(numTraj,numSteps); %current state at each point

%random initial number between the min and max estimates
numWolves(:,1) = floor(rand(numTraj,1)*5 + 2); 

%numWolves(:,1) = 10; %to reproduce book example

times(:,1) = 0;

rValue = 0.0789; %from exponential fit model

%TO CHOOSE OURSELVES
deathRate = 0.2;

%calculate the birth rate so that b-d=r
birthRate = rValue+deathRate;

for j = 1:numTraj
    
    curT = 0;
    curN = numWolves(1,1);
    
    for i = 2:numSteps

        %3 events are 1 birth, 1 death, no change
        %   probs from (5.57) in 5.6.2 of de Vries book
        probBirth = birthRate*curN;
        probDeath = deathRate*curN;

        %lambdaBar to use to sample time to transition
        lambdaBar = probBirth+probDeath+probNoChange;

        %sample time from exponential dist
        sampledT = sampleFromDist(lambdaBar,1);
        curT = curT + sampledT;

        %get uniform sample
        sampledR = rand(1);

        %put it in 0 to lambdaBar range
        sampledLambda = sampledR*lambdaBar;

        %find which state that value corresponds to
        curOption = find(cumsum([probDeath probBirth])>sampledLambda,1,'first');

        changeN = deltaNbyState(curOption);
        curN = curN + changeN;

        numWolves(j,i) = curN;
        times(j,i) = curT;
        
        if(curN<1)
            break
        end

    end

end

figure
stairs(times',numWolves')
axis([0 10 0 inf]);