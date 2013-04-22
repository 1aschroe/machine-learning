function [ err ] = lossL2( y, y_pred )
%LOSSL2 Summary of this function goes here
%   Detailed explanation goes here

err = sqrt(sum((y - y_pred).^2)) / length(y);

end

