function [ err_mean ] = crossValidation( x_train, y_train, c, folds )
%CROSSVALIDATION Summary of this function goes here
%   Detailed explanation goes here

[m, n] = size(x_train);

partition = cvpartition(m,'kfold',folds);

err = zeros(partition.NumTestSets, 1);

for it=1:partition.NumTestSets
    
    x = x_train(partition.training(it),:);
    y = y_train(partition.training(it));
    
    [ w, b ] = solveSVM( c, x, y );
    
    x_test = x_train(partition.test(it),:);
    y_test = y_train(partition.test(it));
    pred = sign(b + x_test * w);
    
    err(it) = loss01(pred, y_test);
end

err_mean = mean(err);

end