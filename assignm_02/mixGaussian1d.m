function [x, y] = mixGaussian1d(n,p1,p2,mu1,mu2,sigma1,sigma2)

r = rand(n,1);
n1 = length(find(r<p1/(p1+p2)));
n2 = n-n1;

x_class1 = mu1 + sigma1*randn(n1,1);
x_class2 = mu2 + sigma2*randn(n2,1);

x = [x_class1;x_class2];
y = ones(n,1);
y(n1+1:n) = 2;
