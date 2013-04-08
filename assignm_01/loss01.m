function err = loss01(y_pred, y)
% LOSS01 Gets as input a prediction calculated by the knnClasifier and
% correct labels y. The function returns the average error (empirical risk
% with respect to the 0-1 loss) for this prediction.

% assuming that y und y_pred sind entweder 1 oder 2

size(y)
size(y_pred)
number_errors = sum(mod(y_pred+y,2));
err = number_errors / length(y);

end