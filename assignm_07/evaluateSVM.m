function [ err_value ] = evaluateSVM( x_train, y_train, x_test, y_test )
%EVALUATESVM Summary of this function goes here
%   Detailed explanation goes here

addpath ..\shared\cvx
addpath ..\shared\cvx\structures
addpath ..\shared\cvx\lib
addpath ..\shared\cvx\functions
addpath ..\shared\cvx\commands
addpath ..\shared\cvx\builtins

c = 10.^(-2:0.5:2);
train_err = zeros(length(c), 1);
test_err = zeros(length(c), 1);

for it=1:length(c)
    train_err(it) = crossValidation(x_train, y_train, c(it), 3);
    [ w, b ] = solveSVM( c(it), x_train, y_train );
    
    pred = sign(b + x_test * w);
    
    test_err(it) = loss01(pred, y_test);
end

[~, min_index] = min(train_err);

err_value = test_err(min_index);

end

