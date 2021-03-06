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
figure; clf; hold all; axis equal;
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
% See function knnClassify

%% Section 5
% see function loss01

%% Section 6
[minK, errValue] = evaluateK(train_data, train_label, test_data, test_label);

pred_label = knnClassify(train_data, train_label, test_data, minK);

figure; clf; hold all; axis equal;
pred_class1 = find(pred_label==1);
pred_class2 = find(pred_label==2);
plot(test_data(pred_class1,1),test_data(pred_class1,2),'r*');
plot(test_data(pred_class2,1),test_data(pred_class2,2),'bo');
plot([1 1],[0 1],'k');
text(1,-0.1,['min K = ', int2str(minK)]);
text(1,-0.2,['err Value = ', num2str(errValue,5)]);

end

