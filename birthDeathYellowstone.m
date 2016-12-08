wolfNumbers = [21	38	62	82	71	118	130	148 ...
    174	172	118	138 170	125	95	98	99	82 95 102];

numPupsBorn = [0	15	65	38	40	69	44	64	74 ...
    90	69	76	85	78	47	45	58	29	42	50];

numPupsSurvived = [0	10	42	32	22	60	43	48 ...
    59	59	22	60	64	22	23	38	34	20	41	40];

tVals = (0:8)';
wolvesUntil2003 = (wolfNumbers(1:9))';
ff = fit(tVals,wolvesUntil2003,'exp1');
n0 = ff.a;
rVal = ff.b;

xxPlot = (0:0.01:8)';
yyPlot = n0.*exp(rVal.*xxPlot);


%estimate the birth rate
%model this starting at 1996, since they were reintroduced in 1995
totalWolvesIfNoDeath = cumsum(numPupsSurvived)+wolfNumbers(1);
tValsNew = (0:7)';
totalWolvesUse = totalWolvesIfNoDeath(1:8)';
birthData = fit(tValsNew,totalWolvesUse,'exp1');

n0birth = birthData.a;
rValBirth = birthData.b;
xxPlot2 = (0:0.01:7)';
yyPlot2 = n0birth.*exp(rValBirth.*xxPlot2);

%%
figure
subplot(1,2,1)
hold on
plot(tVals,wolvesUntil2003,'ro','LineWidth',2);
plot(xxPlot,yyPlot,'r-');
axis([0 8 0 200]);
legend('Wolf Numbers','Exp Fit Model For Pop Growth Rate');
xlabel('Years Since 1995');
ylabel('Number of Wolves');
title('Number of Wolves in Yellowstone 1995-2003');
hold off

subplot(1,2,2)
hold on
plot(tValsNew,totalWolvesUse,'bx','LineWidth',2);
plot(xxPlot2,yyPlot2,'b-');
axis([0 7 0 300]);
legend('Wolf Numbers if No Death',...
    'Exp Fit Model for Birth Rate');
xlabel('Years Since 1996');
ylabel('Number of Wolves');
title('Number of Wolves in Yellowstone 1996-2003 if No Death');
hold off



