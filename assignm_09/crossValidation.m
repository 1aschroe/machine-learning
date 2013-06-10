function [ err_mean ] = crossValidation( x_train, y_train, folds )
%CROSSVALIDATION Summary of this function goes here
%   Detailed explanation goes here

[m, ~] = size(x_train);

partition = cvpartition(m,'kfold',folds);

err = zeros(partition.NumTestSets, 1);
minKs = zeros(partition.NumTestSets, 1);

for it=1:partition.NumTestSets
    
    x = x_train(partition.training(it), :);
    y = y_train(partition.training(it));
    
    x_test = x_train(partition.test(it), :);
    y_test = y_train(partition.test(it));
    
    [minKs(it), err(it)] = evaluateK(x, y, x_test, y_test);
end

err_mean = mean(err);

end