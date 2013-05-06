addpath .\cvx-1.22\cvx
addpath .\cvx-1.22\cvx\structures
addpath .\cvx-1.22\cvx\lib
addpath .\cvx-1.22\cvx\functions
addpath .\cvx-1.22\cvx\commands
addpath .\cvx-1.22\cvx\builtins

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

plot(log(c), log(train_err), log(c), log(test_err));