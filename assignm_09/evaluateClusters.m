function [ err, Y_pred ] = EvaluateClusters( k, Y, Y_clusters )
% Section 2
% Evaluation method: compare the predicted labels to the real values.
% k = number of classes
% Y = labels
% y_clusters = clustered data
realLabels = zeros(1, k);

% retrieve the order of the clusters (i.e. which index belongs to which
% label)
for it = 1 : k
    realLabels(it) = mode(Y(Y_clusters==it));
end

% convert cluster numbaer to class label
Y_pred = realLabels(Y_clusters)';

% calculate 0-1 loss
err = loss01(Y, Y_pred);

end