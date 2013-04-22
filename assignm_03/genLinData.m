function [X,Y] = genLinData(n,sigma)

X = rand(n,1)*3 - 2;
noise = sigma*randn(n,1);
Y = -0.7*X + 1 + noise;