function [ times,numWolves ] = runStochBirthDeath( birthRate,deathRate,...
    initNumWolves,numSteps,numTraj )
%RUNSTOCHBIRTHDEATH runs the Gillespie Algorithm for our case

immRate=0;
[times,numWolves] = runStochBirthDeathImmigration( ...
    birthRate,deathRate,immRate,...
    initNumWolves,numSteps,numTraj );


end

