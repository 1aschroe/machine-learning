function err = loss01(predicted_labels, reference_labels)
% LOSS01 Gets as input predicted and
% correct labels y. The function returns the average error (empirical risk
% with respect to the 0-1 loss) for this prediction.

number_errors = length(find(predicted_labels~=reference_labels));
err = number_errors / length(reference_labels);

end