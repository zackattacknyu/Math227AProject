%pre-1991 data from stochastic model
%{
birthRate = 0.075;
deathRate = 0.045;
n0value = 4;
%}

%post-1991 data from stochastic model
%{
deathRate=0.01;
birthRate=0.21;
n0value = 18;
%}

%yellowstone wolves
birthRate = 0.2813;
deathRate = 0.0883;
n0value = 21;


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