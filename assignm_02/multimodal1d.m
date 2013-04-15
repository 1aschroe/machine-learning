function [x, y] = multimodal1d(n)

n1_1 = floor(0.2*n);
n2 = floor(0.3*n);
n1_2 = n-n1_1-n2;
mu1 = 0; mu2 = 4; mu3 = 7;

x_class1_1 = mu1 + randn(n1_1,1);
x_class2 = mu2 + randn(n2,1);
x_class1_2 = mu3 + randn(n1_2,1);

x = [x_class1_1;x_class1_2;x_class2];
y = ones(n,1);
y(n1_1+n1_2:n) = 2;
