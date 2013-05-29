function [ err ] = lossL2( y, y_pred )
%LOSSL2 Calculates the empirical squared loss between the reference and the
%predicted values and returns it.
% The empirical squared loss computes vector entry wise:
% Square the difference between the reference and the prediction value, sum
% up the results and take the square root and calculate the mean.

err = sqrt(sum((y - y_pred).^2)) / length(y);

end

