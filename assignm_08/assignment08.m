%% Exercise 3

Sigma=[2 0 0;0 1 0;0 0 4];
mu=[0,0,0];
d = 3;
n = 2000;

S1 = chol(Sigma);
X = repmat(mu,n,1) + randn(n,d)*S1;

plot3(X(:,1), X(:,2), X(:,3), '.')

[v, d] = eig(Sigma)

Sigma*v
