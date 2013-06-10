function err = loss01(y_pred, y)
% LOSS01 Gets as input a prediction calculated by the knnClasifiy and
% correct labels y. The function returns the average error (empirical risk
% with respect to the 0-1 loss) for this prediction.

% assuming that y and y_pred are either 1 or 2

%number_errors = sum(mod(y_pred+y,2));
%number_errors=sum(ne(y_pred, y)); %problem equal = 1 not 0..., so i used ne(not equal)
number_errors = length(find(y_pred~=y));
err = number_errors / length(y);

end