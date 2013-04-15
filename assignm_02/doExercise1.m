function [ ] = doExercise1( )
%DOEXERCISE1 This is our implementation for exercise 1 (very slow!!!)
%% Section 1
load('20Newsgroup.mat');
trainList = find(y_train==6 | y_train==8);
x_train_6_8 = x_train(trainList,:);
y_train_6_8 = y_train(trainList);

%% Section 2
load('20Newsgroup.mat');
testList = find(y_test==6 | y_test==8);
x_test_6_8 = x_test(testList,:);
y_test_6_8 = y_test(testList);

%% Section 3
x_test_cropped = x_test_6_8(:,1:size(x_train_6_8,2));
y_test_cropped = y_test_6_8(:,1:size(y_train_6_8,2));

%% Section 4
evaluateK(x_train, y_train, x_test_cropped, y_test_cropped);

end

