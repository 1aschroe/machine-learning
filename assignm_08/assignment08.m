function [] = assignment08()

%% Exercise 3

Sigma=[2 0 0;0 1 0;0 0 4];
mu=[0,0,0];
n = 2000;

X = GenerateData(Sigma, mu, n);

plot3(X(:,1), X(:,2), X(:,3), '.')

v = sqrt(2)/2 * [ 1, 1; -1, 1 ];
d = [ 3, 0; 0, 1 ];

Sigma = v * d * v';
mu = [0 0];

X = GenerateData(Sigma, mu, 400);
figure;
hold on;
plot(X(:,1), X(:,2), '.');

%% Exercise 4

% Sigma already has this value: Sigma = [2,-1;-1,2];
mu = [1, 1];

X= GenerateData(Sigma, mu, 500);
[V, D] = PCA(X)

[V, D] = eig(Sigma)

% one can see that up to an error below 10 % these values agree
end

function [X] = GenerateData(Sigma, mu, n)

S1 = chol(Sigma);
X = repmat(mu,n,1) + randn(n,size(Sigma,1))*S1;

end