function [ ] = doExercise2( normalized )
%DOEXERCISE2 Summary of this function goes here
%   Detailed explanation goes here

%% Äkserßais tu

[X, Y] = loadData();
% Section 1
k = 10;
W = buildKnnGraph(X, k);
sigma = 1000;
W(W~=0) = exp(-W(W~=0).^2/(2*sigma^2));

% Section 2
degrees = ones(1, size(W,1)) * W;
L = diag(degrees) - W;

if normalized
    % up to now, L is unnormalized
    D05 = diag(sqrt(1./degrees));
    L = D05*L*D05;
end

% Section 3
[V, ~] = eig(full(L));
figure;
scatter3(V(:,2),V(:,3),V(:,4), 10, Y);
axis equal;

% Section 4
[V, D] = eigs(L, 4, 'sm');

k = 4;
Y_clusters = kmeans(V,k, 'replicates', 5, 'Display', 'final');

[err, ~] = evaluateClusters(k, Y, Y_clusters)
end

