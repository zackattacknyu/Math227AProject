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
meanWolvesPost1991 = meanTotalWolves(12:end);

tValsPre91 = (0:10)';
ffPre91 = fit(tValsPre91,meanWolvesPre1991','exp1');
n0pre91 = ffPre91.a; %initial population

tValsPost91 = (0:9)';
ffPost91 = fit(tValsPost91,meanWolvesPost1991','exp1');
n0post91 = ffPost91.a; %initial population

tValsPost91 = (0:9)';
ffPost91 = fit(tValsPost91,meanWolvesPost1991','exp1');
n0post91 = ffPost91.a; %initial population

%reproductive fitness coeff. r = bb-dd where
%   bb is birth rate, dd is death rate
rValuePre91 = ffPre91.b; 
rValuePost91 = ffPost91.b; 

xxPlot = (0:0.01:10);
yyPlot = n0pre91.*exp(rValuePre91.*xxPlot);

xxPlot2 = (0:0.01:9);
yyPlot2 = n0post91.*exp(rValuePost91.*xxPlot2);

xxPlot3 = (0:0.01:20);
yyPlot3 = n0pre91.*exp(rValuePre91.*xxPlot3);

immBeta = 0.5;
immBeta2 = 1;
immBeta3 = 2;
meanWolvesIn1990 = 8;
yyPlot3Imm = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta/rValuePre91;
yyPlot3Imm2 = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta2/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta2/rValuePre91;
yyPlot3Imm3 = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta3/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta3/rValuePre91;


%plot the pre-1991 data
figure
hold on
plot(tValsPre91,meanWolvesPre1991,'b.');
plot(xxPlot,yyPlot,'r-');
axis([0 11 0 11]);
legend('Mean Wolf Numbers','Exponential Fit Model');
xlabel('Years Since 1980');
ylabel('Mean Number of Wolves');
title('Mean Number of Wolves over Time before 1991');
hold off

%plot the post-1991 data
figure
hold on
plot(tValsPost91,meanWolvesPost1991,'b.');
plot(xxPlot2,yyPlot2,'r-');
axis([0 10 0 100]);
legend('Mean Wolf Numbers','Exponential Fit Model');
xlabel('Years Since 1990');
ylabel('Mean Number of Wolves');
title('Mean Number of Wolves over Time before 1991');
hold off


figure
hold on
plot(tValsPre91,meanWolvesPre1991,'rx');
plot(tValsPost91,meanWolvesPost1991,'g.');
plot(xxPlot,yyPlot,'r-');
plot(xxPlot2,yyPlot2,'g-');
axis([0 11 0 100]);
legend('Mean Wolf Numbers (since 1980)','Mean Wolf Numbers (since 1990)',...
    'Exponential Fit Model for pre-1991','Exponential Fit Model for post-1991');
xlabel('Years Since 1990');
ylabel('Mean Number of Wolves');
title('Mean Number of Wolves over Time before 1991');
hold off

figure
hold on
plot(0:20,meanTotalWolves,'b.');
plot(xxPlot3,yyPlot3,'r-');
plot(xxPlot3,yyPlot3Imm,'g-');
plot(xxPlot3,yyPlot3Imm2,'g--');
plot(xxPlot3,yyPlot3Imm3,'k--');
axis([0 20 0 100]);
legend('Mean Wolf Numbers','Exponential Fit Model');
xlabel('Years Since 1980');
ylabel('Mean Number of Wolves');
title('Mean Number of Wolves over Time before 1991');
hold off

%{

NOTE:

SHOULD DO THE FOLLOWING
- TREAT 1980-1991 AS ONE PERIOD
- DURING 1991, IMMIGRATION AND OTHER DIFFICULT TO MODEL EVENTS HAPPENED
-   THE SYSTEM ALSO CHANGED IN THAT TIME PERIOD
- THUS I WILL TREAT WINTER 1991-PRESENT AS COMPLETELY NEW TIME PERIOD


%}
