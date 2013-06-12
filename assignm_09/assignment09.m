%% Exercise 1
% Section 1
% Use kMeans on USPS dataset
[X, Y] = loadData();

k = 4;

% Perform kmeans with k classes and 5 runs
% Y_clusters is a vector containing numbers of the assigned class for each
% entry in X
Y_clusters = kmeans(X,k, 'replicates', 5, 'Display', 'final');

% Section 2: evaluate clusters
[cluster_error, Y_pred] = evaluateClusters(k, Y, Y_clusters);
cluster_error

% Section 3
% We evaluate whether the closest k neighbours of the points in each
% cluster are in the same predicted cluster. If so, we value the clustering
% to be good.
% What 'good' means might only be validated when comparing the results to
% otheralgorithms
knn_evaluation = crossValidation(X, Y_pred, 10)

% Section 4
% Distance tells kMeans how to measure the distances in the n-dimensional
% space

Y_clusters = kmeans(X,k, 'replicates', 5, 'Distance', 'cityblock');

distance_cityblock = evaluateClusters(k, Y, Y_clusters)

Y_clusters = kmeans(X,k, 'replicates', 5, 'Distance', 'cosine');

distance_cosine = evaluateClusters(k, Y, Y_clusters)

% values from two runs:
% eucledianDistance:	11,25 %     11,38 %
% cityblock:            13,38 %     14,12 %
% cosine:               13,00 %     14,00 %
% kNN-compare:           4,00 %      4,75 %

% Section 5
% Working with cityblock distance means using working within L1-norm. This
% could lead to sparser results

%% Exercise 2
doExercise2(false);

doExercise2(true);