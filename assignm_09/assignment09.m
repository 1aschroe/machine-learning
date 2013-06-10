%% Exercise 1
% Section 1
[X, Y] = loadData();

k = 4;

Y_clusters = kmeans(X,k, 'replicates', 5, 'Display', 'final');

[err, Y_pred] = evaluateClusters(k, Y, Y_clusters);
err

% Section 3
% We evaluate whether the closest k neighbours of the points in each
% cluster are in the same predicted cluster. If so, we value the clustering
% to be good.

crossValidation(X, Y_pred, 10)

% Section 4

Y_clusters = kmeans(X,k, 'replicates', 5, 'Display', 'final', 'Distance', 'cityblock');

evaluateClusters(k, Y, Y_clusters)

Y_clusters = kmeans(X,k, 'replicates', 5, 'Display', 'final', 'Distance', 'cosine');

evaluateClusters(k, Y, Y_clusters)

% values from two runs:
% eucledianDistance:	11,25 %     11,38 %
% cityblock:            13,38 %     14,12 %
% cosine:               13,00 %     14,00 %
% kNN-compare:           4,00 %      4,75 %

%% Exercise 2
doExercise2(false);

doExercise2(true);