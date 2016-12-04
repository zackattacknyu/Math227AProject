function [ res ] = sampleFromDist( lambda, Nvals )
%SAMPLEFROMDIST obtain N samples from distribution

%{
For Part A, sample y from 0 to 1
then lambda * exp(-lambda * t ) = lambda*y
since the result will range from 0 to lambda

log of both sides gives
-lambda*t = log(y)
t = -log(y)/lambda
%}

yVec = rand(Nvals,1);
res = -log(yVec)./lambda;

end

