function [ ] = doExercise1( trainN1, trainN2, testNumbers )
%Assignment one Exercises 1-8 can be found here.


%% Section 1
% The data for class 1 is random 30 x 2 matrix with values in the interval (0.0, 1.0).
% The data for class 2 is again random 30 x 2 matrix, but the first column has
% values in the interval (1.0, 2.0).
% The data is represented as 2D points when plotted.

n1 = trainN1;
train_data_class1 = rand(n1,2);
n2 = trainN2;
train_data_class2 = rand(n2,2) + ones(n2,2)*[1 0; 0 0];
train_data = [train_data_class1; train_data_class2];
train_label(1:n1,1) = 1;
train_label(n1+1:n1+n2,1) = 2;

%% Section 2
figure(1); clf; hold all; axis equal;
plot(train_data(1:n1,1), train_data(1:n1,2), 'r*');
plot(train_data(n1+1:n1+n2,1), train_data(n1+1:n1+n2,2), 'bo');

%% Section 3
n1 = testNumbers;
test_data_class1 = rand(n1,2);
n2 = testNumbers;
test_data_class2 = rand(n2,2) + ones(n2,2)*[1 0; 0 0];
test_data = [test_data_class1; test_data_class2];
test_label(1:n1,1) = 1;
test_label(n1+1:n1+n2,1) = 2;

%% Section 4
%% See function knnClassify

%% Section 5
%% see function loss01

%% Section 6
k_values = [1 3 5 7 9 10 11 15 19 20];
error_test = zeros(1, length(k_values));
error_train = zeros(1, length(k_values));
for it = 1:length(k_values)
    test_pred_label = knnClassify(train_data, train_label, test_data, k_values(it));
    error_test(it) = loss01(test_pred_label, test_label);
    train_pred_label = knnClassify(train_data, train_label, train_data, k_values(it));
    error_train(it) = loss01(train_pred_label, train_label);
end

%% Section 7

figure(2); clf; hold all;
plot(k_values,error_test,'r*:');
plot(k_values,error_train,'b.-');


%% Section 8
[sorted, index] = sort(error_test);
minK = k_values(index(1));
pred_label = knnClassify(train_data, train_label, test_data, minK);

figure(3); clf; hold all; axis equal;
pred_class1 = find(pred_label==1);
pred_class2 = find(pred_label==2);
plot(test_data(pred_class1,1),test_data(pred_class1,2),'r*');
plot(test_data(pred_class2,1),test_data(pred_class2,2),'bo');
plot([1 1],[0 1],'k');
text(1,-0.1,['min K = ', int2str(minK)]);
errValue=sorted(1)
text(1,-0.2,['err Value = ', num2str(errValue,5)]);

end

