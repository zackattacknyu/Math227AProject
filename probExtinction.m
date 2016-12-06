%pre-1991 data from stochastic model
birthRate = 0.075;
deathRate = 0.045;
n0value = 4;


%post-1991 data from stochastic model
%{
deathRate=0.03;
birthRate=0.23;
n0value = 18;
%}

%all data from stochastic model
%{
birthRate = 0.165;
deathRate = 0.01;
n0value = 4;
%}

rValue = birthRate-deathRate;
tt = 0:0.01:20;

%probability of extinction values
pValsNumer = deathRate.*(1-exp(-rValue.*tt));
pValsDenom = birthRate - deathRate.*exp(-rValue.*tt);
pVals = (pValsNumer./pValsDenom).^n0value;

plot(tt,pVals,'r-')
xlabel('Time Since Winter 1980-1981');
ylabel('Probability of Extinction');

probExtinction = (deathRate/birthRate)^n0value