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

%before and after 1991
meanWolvesPre1991 = meanTotalWolves(1:11);
meanWolvesPost1991 = meanTotalWolves(11:end);
%%

tVals = (0:10)';
ffPre91 = fit(tVals,meanWolvesPre1991','exp1');
n0pre91 = ffPre91.a; %initial population

tValsPost1991 = (0:10)';
ffPost91 = fit(tVals,meanWolvesPost1991','exp1');
n0post91 = ffPost91.a; %initial population

%reproductive fitness coeff. r = bb-dd where
%   bb is birth rate, dd is death rate
rValuePre91 = ffPre91.b; 
rValuePost91 = ffPost91.b; 

xxPlot = (0:0.01:10);
yyPlot = n0pre91.*exp(rValuePre91.*xxPlot);
yyPlot2 = n0post91.*exp(rValuePost91.*xxPlot);

%plot the pre-1991 data
figure
hold on
plot(tValsPre1991,meanWolvesPre1991,'b.');
plot(xxPlot,yyPlot,'r-');
axis([0 11 0 11]);
legend('Mean Wolf Numbers','Exponential Fit Model');
xlabel('Years Since 1980');
ylabel('Mean Number of Wolves');
title('Mean Number of Wolves over Time before 1991');
hold off

%plot the pre-1991 data
figure
hold on
plot(tValsPost1991,meanWolvesPost1991,'b.');
plot(xxPlot,yyPlot2,'r-');
axis([0 11 0 100]);
legend('Mean Wolf Numbers','Exponential Fit Model');
xlabel('Years Since 1990');
ylabel('Mean Number of Wolves');
title('Mean Number of Wolves over Time before 1991');
hold off
