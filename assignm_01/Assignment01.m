clear all; clc;


%% Section 1
% The data for class 1 is random 30 x 2 matrix with values in the interval (0.0, 1.0).
% The data for class 2 is again random 30 x 2 matrix, but the first column has
% values in the interval (1.0, 2.0).
% The data is represented as 2D points when ploted.

n1 = 30;
train_data_class1 = rand(n1,2);
n2 = 30;
train_data_class2 = rand(n2,2) + ones(n2,2)*[1 0; 0 0];
train_data = [train_data_class1; train_data_class2];
train_label(1:n1) = 1;
train_label(n1+1:n1+n2) = 2;

%% Section 2
figure(1); clf; hold all; axis equal;
plot(train_data(1:n1,1), train_data(1:n1,2), 'r*');
plot(train_data(n1+1:n1+n2,1), train_data(n1+1:n1+n2,2), 'bo');

%% Section 3
n1 = 100;
test_data_class1 = rand(n1,2);
n2 = 100;
test_data_class2 = rand(n2,2) + ones(n2,2)*[1 0; 0 0];
test_data = [test_data_class1; test_data_class2];
test_label(1:n1) = 1;
test_label(n1+1:n1+n2) = 2;

figure(1); clf; hold all; axis equal;
plot(test_data(1:n1,1), test_data(1:n1,2), 'r*');
plot(test_data(n1+1:n1+n2,1), test_data(n1+1:n1+n2,2), 'bo');

%% Section 4
pred_label = knnClassify(train_data, train_label, test_data, 5);

%% Section 5
loss01(pred_label, test_label);