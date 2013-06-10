function [ err, Y_pred ] = EvaluateClusters( k, Y, Y_clusters )
%EVALUATECLUSTERS Summary of this function goes here
%   Detailed explanation goes here

% Section 2
% Evaluation method: compare the predicted labels to the real values.

realLabels = zeros(1, k);
for it = 1 : k
    realLabels(it) = mode(Y(Y_clusters==it));
end

Y_pred = realLabels(Y_clusters)';

err = loss01(Y, Y_pred);

end