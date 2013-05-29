addpath ..\shared\cvx
addpath ..\shared\cvx\structures
addpath ..\shared\cvx\lib
addpath ..\shared\cvx\functions
addpath ..\shared\cvx\commands
addpath ..\shared\cvx\builtins

load('cancer-data.mat');

c = 10.^(-2:0.5:2);
train_err = zeros(length(c), 1);
test_err = zeros(length(c), 1);

for it=1:length(c)
    train_err(it) = crossValidation(cancerInput_train, cancerTarget_train, c(it), 3);
    [ w, b ] = solveSVM( c(it), cancerInput_train, cancerTarget_train );
    
    pred = sign(b + cancerInput_test * w);
    
    test_err(it) = loss01(pred, cancerTarget_test);
end

loglog(c, train_err, c, test_err);