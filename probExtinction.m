%pre-1991 data from stochastic model
%{
birthRate = 0.060;
deathRate = 0.045;
n0value = 4;
%}

%post-1991 data from stochastic model

deathRate=0.03;
birthRate=0.23;
n0value = 18;


rValue = birthRate-deathRate;
tt = 0:0.01:200;

%probability of extinction values
pValsNumer = deathRate.*(1-exp(-rValue.*tt));
pValsDenom = birthRate - deathRate.*exp(-rValue.*tt);
pVals = (pValsNumer./pValsDenom).^n0value;

plot(tt,pVals,'r-')

probExtinction = (deathRate/birthRate)^n0value