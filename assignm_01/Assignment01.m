clear all; clc; clf;

%% Exercise 1
%% Sections 1-8:
doAssignment1(30,30, 100);

%% Section 9
doAssignment1(200,200, 100);

%% Section 10
%% The error value for uneven classes always considerably bigger.
%% The error value increases monotonically with respect to k.
doAssignment1(1000,50, 100);


%% Exercise 2
%% Section 1
clear all; clc;
load('usps_train.mat');
trList = find(train_label==2 | train_label==3);
x_train = double(train_data(trList,:));
y_train = double(train_label(trList));

%% Section 2
load('usps_test.mat');
testList = find(test_label==2 | test_label==3);
x_test = double(test_data(testList,:));
y_test = double(test_label(testList));

%% Section 3
figure(4);
dig = reshape(train_data(1012,:),16,16);
imagesc(dig)
colormap('gray');

%% Section 4
k_values = [1 3 5 7 9 10 11 15];
error_test = zeros(1, length(k_values));
error_train = zeros(1, length(k_values));
figure(5); clf; hold all;
for it = 1:length(k_values)
    disp(['Working on test data for k=' int2str(k_values(it))]);
    test_pred_label = knnClassify(x_train, y_train, x_test, k_values(it));
    error_test(it) = loss01(test_pred_label, y_test);
    
    plot(k_values(1:it),error_test(1:it),'r*:');
    
    disp(['Working on training data for k=' int2str(k_values(it))]);
    train_pred_label = knnClassify(x_train, y_train, x_train, k_values(it));
    error_train(it) = loss01(train_pred_label, y_train);
    
    plot(k_values(1:it),error_train(1:it),'b.-');
end
