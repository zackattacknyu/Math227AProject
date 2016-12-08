function [ times,numWolves ] = runStochBirthDeath( birthRate,deathRate,...
    initNumWolves,numSteps,numTraj )
%RUNSTOCHBIRTHDEATH runs the Gillespie Algorithm for our case

times = zeros(numTraj,numSteps); %time point
numWolves = zeros(numTraj,numSteps); %current state at each point
numWolves(:,1) = initNumWolves; 

times(:,1) = 0;
deltaNbyState = [-1 1];

for j = 1:numTraj
    
    curT = 0;
    curN = numWolves(1,1);
    
    for i = 2:numSteps

        %3 events are 1 birth, 1 death, no change
        %   probs from (5.57) in 5.6.2 of de Vries book
        probBirth = birthRate*curN;
        probDeath = deathRate*curN;

        %lambdaBar to use to sample time to transition
        lambdaBar = probBirth+probDeath;

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

end

