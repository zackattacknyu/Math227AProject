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

tValsAll = (0:20)';
ffAll = fit(tValsAll,meanTotalWolves','exp1');
n0All = ffAll.a; %initial population

%reproductive fitness coeff. r = bb-dd where
%   bb is birth rate, dd is death rate
rValuePre91 = ffPre91.b; 
rValuePost91 = ffPost91.b; 
rValueAll = ffAll.b;

xxPlot = (0:0.01:10);
yyPlot = n0pre91.*exp(rValuePre91.*xxPlot);

xxPlot2 = (0:0.01:9);
yyPlot2 = n0post91.*exp(rValuePost91.*xxPlot2);

xxPlotA = (0:0.01:10);
yyPlotA = n0pre91.*exp(rValuePre91.*xxPlotA);

xxPlot2A = (11:0.01:20);
yyPlot2A = n0post91.*exp(rValuePost91.*(xxPlot2A-11));

xxPlot3 = (0:0.01:20);
yyPlot3 = n0pre91.*exp(rValuePre91.*xxPlot3);

xxPlot4 = (0:0.01:20);
yyPlot4 = n0All.*exp(rValueAll.*xxPlot4);

immBeta = 0.5;
immBeta2 = 1;
immBeta3 = 2.5;
meanWolvesIn1990 = 8;
yyPlot3Imm = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta/rValuePre91;
yyPlot3Imm2 = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta2/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta2/rValuePre91;
yyPlot3Imm3 = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta3/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta3/rValuePre91;

%plot all data
figure
hold on
plot(tValsAll,meanTotalWolves,'b.');
plot(xxPlotA,yyPlotA,'g-');
plot(xxPlot2A,yyPlot2A,'r-');
axis([0 20 0 100]);
legend('Wolf Population Data','Exponential Fit For Pre-1991 Data',...
    'Exponential Fit For Post-1991 Data');
xlabel('Years Since Winter 1980-1981');
ylabel('Mean Number of Wolves');
hold off

figure
hold on
plot(0:20,meanTotalWolves,'b.');
plot(xxPlot3,yyPlot3,'r-');
plot(xxPlot3,yyPlot3Imm3,'k--');
axis([0 20 0 100]);
legend('Wolf Population Data','Model prediction where r from pre-1991 data, beta=0',...
    'Model prediction where r from pre-1991 Data, beta=2.5');
xlabel('Years Since 1980');
ylabel('Mean Number of Wolves');
hold off


%{

NOTE:

SHOULD DO THE FOLLOWING
- TREAT 1980-1991 AS ONE PERIOD
- DURING 1991, IMMIGRATION AND OTHER DIFFICULT TO MODEL EVENTS HAPPENED
-   THE SYSTEM ALSO CHANGED IN THAT TIME PERIOD
- THUS I WILL TREAT WINTER 1991-PRESENT AS COMPLETELY NEW TIME PERIOD


%}
