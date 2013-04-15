function [x, y] = mixGaussian2d(n,p1,p2)

r = rand(n,1);
n1 = length(find(r<p1/(p1+p2)));
n2 = n-n1;

mu1 = [0 -2];
mu2 = [0 2];
sigma1 = [1 0;0 2];
sigma2 = [1 0;0 1];

R1 = chol(sigma1);
x_class1 = repmat(mu1,n1,1) + randn(n1,2)*R1;
R2 = chol(sigma2);
x_class2 = repmat(mu2,n2,1) + randn(n2,2)*R2;

x = [x_class1;x_class2];
y = ones(n,1);
y(n1+1:n) = 2;
