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