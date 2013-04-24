function [ err ] = doExercise1( outlier, x_train, y_train, x_test, y_test )
%Performs Section 1-6 of Exercise 1.

%% Exercise 1
%% Section 1

hold on;
plot(x_train,y_train, 'kx');
plot(x_test,y_test, 'r.');

%% Section 2

% concatenating 1 to each training point
x_train_bias = [x_train, ones(length(x_train),1)];

%% Section 3
% Compute the LLS.
w = LLS(x_train_bias, y_train);

% these values are - as expected - very close to -0.7 and 1 from genLinData

%% Section 4
% Create the function f with computed values a and b from the LLS.
a = w(1);
b = w(2);
f = @(x) a*x+b;

% plot the function for x=-2:1
if outlier
    % Increase plotrange for outlier
    fplot(f, [-2,10]);
else
    % plot only values in range of generated data
    fplot(f, [-2,1]);
end

%% Section 5
% compute the Y values for the test data through the genrated LLS function.
y_test_predicted = f(x_test);

plot(x_test, y_test_predicted, 'go');

%% Section 6
% see function lossL2

err = lossL2(y_test, y_test_predicted);

end

