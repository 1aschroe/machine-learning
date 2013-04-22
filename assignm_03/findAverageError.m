function [ mean_err ] = findAverageError( sigma, n, outlier )
%FINDAVERAGEERROR Summary of this function goes here
%   Detailed explanation goes here

figure; clf;

%% Section 7
err = zeros(n,1);
for it=1:n
    [x_train,y_train] = genLinData(50,sigma);
    [x_test,y_test] = genLinData(30,sigma);
    
    if outlier
        x_train = [x_train; 10];
        y_train = [y_train; 10];
    end
    err(it) = doExercise1(outlier, x_train, y_train, x_test, y_test);
end
mean_err = mean(err);
end

