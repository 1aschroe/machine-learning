function err = loss01(y_pred, y)
% LOSS01 Gets as input a prediction calculated by the knnClasifiy and
% correct labels y. The function returns the average error (empirical risk
% with respect to the 0-1 loss) for this prediction.

number_errors = length(find(y_pred~=y));
err = number_errors / length(y);

end