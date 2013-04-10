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

%% Section 3
figure(4);
dig = reshape(train_data(1012,:),16,16);
imagesc(dig)
colormap('gray');

%% Section 4
k_values = [1 3 5 7 9 10 11 15];
error_test = zeros(1, length(k_values));
error_train = zeros(1, length(k_values));
for it = 1:length(k_values)
    disp(['Working on test data for k=' int2str(k_values(it))]);
    tic
    test_pred_label = knnClassify(x_train, y_train, x_test, k_values(it));
    error_test(it) = loss01(test_pred_label, y_test);
    toc
    
    disp(['Working on training data for k=' int2str(k_values(it))]);
    tic
    train_pred_label = knnClassify(x_train, y_train, x_train, k_values(it));
    error_train(it) = loss01(train_pred_label, y_train);
    toc
end

% Plotting
figure(5); clf; hold all;
plot(k_values(1:it),error_test(1:it),'r*:');
plot(k_values(1:it),error_train(1:it),'b.-');
end

