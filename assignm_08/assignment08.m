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

%% Exercise 5

[x_train, y_train, ~, ~] = loadUSPSData();
[V, D] = PCA(x_train(y_train==5,:));
eigenvalues = D * ones(size(D, 1), 1);
[~, largestIndices] = sort(eigenvalues, 'descend');
figure;
principalComponent = V(:, largestIndices(1));
drawNumber(principalComponent);
figure;
secondComponent = V(:, largestIndices(2));
drawNumber(secondComponent);

%% Exercise 6
[x_train, y_train, ~, ~] = loadUSPSData();

sampleSize = 300;
maxDigit = 4;
samples = zeros(maxDigit*sampleSize, 1);
for digit = 1 : maxDigit
    indices = randsample(length(find(y_train==digit)), sampleSize);
    samples((digit - 1)*sampleSize + 1 : digit*sampleSize) = ...
        indices + find(y_train==digit, 1 );
end

X = x_train(samples, :);
Y = y_train(samples);
k = 10;

A = buildKnnGraph(X,k);
D = graphallshortestpaths(A,'Directed', false);
xy = Isomap(D,2);
figure;
scatter(xy(:,1),xy(:,2),10,Y,'filled');

% larger k causes all data to be mapped with a lot of overlap
% smaller k causes single classes to be disconnected
end

function [X] = GenerateData(Sigma, mu, n)

S1 = chol(Sigma);
X = repmat(mu,n,1) + randn(n,size(Sigma,1))*S1;

end