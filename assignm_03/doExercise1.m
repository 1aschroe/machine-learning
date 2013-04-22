function [ err ] = doExercise1( outlier, x_train, y_train, x_test, y_test )
%DOEXERCISE1 Summary of this function goes here
%   Detailed explanation goes here

%% Exercise 1
%% Section 1

hold on;
plot(x_train,y_train, 'kx');
plot(x_test,y_test, 'r.');

% Description:
% genLinData generates a vector of n values between -2 and 1. Noise of
% amplitude sigma is added to each entry's value Y, which is the linear
% function -0.7*X + 1.

%% Section 2

% concatenating 1 to each training point
x_train_bias = [x_train, ones(length(x_train),1)];

%% Section 3

w = LLS(x_train_bias, y_train);

% these values are - as expected - very close to -0.7 and 1 from genLinData

%% Section 4

f = @(x) w(1)*x+w(2);

if outlier
    fplot(f, [-2,10]);
else
    fplot(f, [-2,1]);
end

%% Section 5

pred_test = f(x_test);

plot(x_test, pred_test, 'go');

%% Section 6
% see function lossL2

err = lossL2(y_test, pred_test);

end

