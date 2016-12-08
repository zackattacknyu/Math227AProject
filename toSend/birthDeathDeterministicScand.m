%{
Does the deterministic exponential fits
on the Scandinavian wolves
%}

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

%before and after 1991, values for time t
tValsPre91 = (0:10)';
tValsPost91 = (0:9)';

%does exponential fit on pre-1991 data
ffPre91 = fit(tValsPre91,meanWolvesPre1991','exp1');

%does exponential fit on post-1991 data
ffPost91 = fit(tValsPost91,meanWolvesPost1991','exp1');

%initial population values from exponential fit
n0pre91 = ffPre91.a; 
n0post91 = ffPost91.a; 

%reproductive fitness coeff. r = b-d where
%   b is birth rate, d is death rate
rValuePre91 = ffPre91.b; 
rValuePost91 = ffPost91.b; 

%makes the pre-1991 exponential graph values
xxPlotA = (0:0.01:10);
yyPlotA = n0pre91.*exp(rValuePre91.*xxPlotA);

%makes the post-1991 exponential graph values
xxPlot2A = (11:0.01:20);
yyPlot2A = n0post91.*exp(rValuePost91.*(xxPlot2A-11));

%makes the pre-1991 exponential graph values for whole time period
% assuming no immigration
xxPlot3 = (0:0.01:20);
yyPlot3 = n0pre91.*exp(rValuePre91.*xxPlot3);

%makes the pre-1991 exponential graph values
% with assumption of immigration
immBeta2 = 2.5;
immBeta3 = 4.75;
meanWolvesIn1990 = 8;
yyPlot3Imm2 = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta2/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta2/rValuePre91;
yyPlot3Imm3 = meanWolvesIn1990.*exp(rValuePre91.*(xxPlot3-10)) + ...
    (immBeta3/rValuePre91).*exp(rValuePre91.*(xxPlot3-10)) - immBeta3/rValuePre91;

%plot pre-1991 and post-1991 fits
figure
hold on
plot(0:20,meanTotalWolves,'b.');
plot(xxPlotA,yyPlotA,'g-');
plot(xxPlot2A,yyPlot2A,'r-');
axis([0 20 0 100]);
legend('Wolf Population Data','Exponential Fit For Pre-1991 Data',...
    'Exponential Fit For Post-1991 Data');
xlabel('Years Since Winter 1980-1981');
ylabel('Mean Number of Wolves');
hold off

%plot model assuming immigration has occurred
figure
hold on
plot(0:20,meanTotalWolves,'b.');
plot(xxPlot3,yyPlot3,'r-');
plot(xxPlot3,yyPlot3Imm2,'g--');
plot(xxPlot3,yyPlot3Imm3,'k--');
axis([0 20 0 100]);
legend('Wolf Population Data','Model prediction, r from pre-1991 data, beta=0',...
    'Model prediction, r from pre-1991 Data, beta=2.5',...
    'Model prediction, r from pre-1991 Data, beta=4.75');
xlabel('Years Since Winter 1980-1981');
ylabel('Mean Number of Wolves');
hold off
