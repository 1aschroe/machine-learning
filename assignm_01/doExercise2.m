function [ ] = doExercise2( number1, number2 )

%% Section 1
load('usps_train.mat');
trList = find(train_label==number1 | train_label==number2);
x_train = double(train_data(trList,:));
y_train = double(train_label(trList));

%% Section 2
load('usps_test.mat');
testList = find(test_label==number1 | test_label==number2);
x_test = double(test_data(testList,:));
y_test = double(test_label(testList));


%% Section 4
evaluateK(x_train, y_train, x_test, y_test);
end

