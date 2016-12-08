%This calculates the probability of 
% extinction using the formula in 5.6.2
% of de Vries

%{
Here are the 3 situations where I calculated
probability of extinction. uncomment whichever
line is currently relevant and comment out the rest
%}

%pre-1991 data from stochastic model
%birthRate = 0.075; deathRate = 0.045; n0value = 4;

%post-1991 data from stochastic model
%deathRate=0.01; birthRate=0.21; n0value = 18;

%yellowstone wolves
birthRate = 0.2813; deathRate = 0.0883; n0value = 21;


%{
Here I made the graph of probability of extinction
and had Matlab output the overall probability
%}

%this will do a plot of probability of extinction
%   versus time
rValue = birthRate-deathRate;
tt = 0:0.01:20;
pValsNumer = deathRate.*(1-exp(-rValue.*tt));
pValsDenom = birthRate - deathRate.*exp(-rValue.*tt);
pVals = (pValsNumer./pValsDenom).^n0value;
plot(tt,pVals,'r-')
xlabel('Time Since Winter 1980-1981');
ylabel('Probability of Extinction');

%this outputs the overall probability of extinction
probExtinction = (deathRate/birthRate)^n0value