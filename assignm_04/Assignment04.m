%% Exercise 1
% copied from Assignment 1 Exercise 2
load('usps_train.mat');
load('usps_test.mat');
%% Section 1
% find indexes of labels 4 & 9
trainList = find(train_label==4 | train_label==9);
% load train data of indexes
% x_train contains grayscale vectors (16x16 bit)
x_train = double(train_data(trainList,:));
% y_train the labels to the vectors
y_train = double(train_label(trainList));


testList = find(test_label==4 | test_label==9);
% load test data of indexes
% x_test contains grayscale vectors (16x16 bit)
x_test = double(test_data(testList,:));
% y_test the labels to the vectors
y_test = double(test_label(testList));
% end of copy

% cls is a discriminant analysis classifier based on the input variables
cls = ClassificationDiscriminant.fit(x_train, y_train);

% display of the linear coefficients for predicting the class
% positive values are more likely to be class 1 (4) and negative values are
% more likely to be class 2 (9)
dig = reshape(cls.Coeffs(1,2).Linear,16,16);
imagesc(dig);

%% Section 2

% positive values indicate class 1 (4) negative class 2 (9), we take the
% sign to predict the class
pred_labels = sign(evaluateCls(cls, 1, 2, x_test));

% the real y-values are converted to -1 and 1 (all entries except 4 and 9 are zero,
% so (y_test==4) is 1 where 4 is the value and '-(y_test==9)' is -1 where 9
% is the value.
ref_labels = (y_test==4)-(y_test==9);
% calculate the loss
err_4_9 = loss01(pred_labels, ref_labels)

%% Exercise 2
% Load all data for Exercise 2
trainList = find(train_label==4 | train_label==3 | train_label==2 | train_label==1);
x_train = double(train_data(trainList,:));
y_train = double(train_label(trainList));

testList = find(test_label==4 | test_label==3 | test_label==2 | test_label==1);
x_test = double(test_data(testList,:));
y_test = double(test_label(testList));

pred_labels = clsOneVsAll(x_train, y_train, x_test);

% We compare the predicted labels with the reference labels to generate our
% loss
err_one_vs_all = loss01(pred_labels, y_test)

% Our weights are stored in a 400x6 matrix, where each column represents a 
% unique pair of classes:
classRef = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];

pred_labels = clsOneVsOne(x_train, y_train, x_test, classRef);

% Compare the predicted labels with the reference labels to generate loss
err_one_vs_one = loss01(pred_labels, y_test)

%% Exercise 5

load('dataRidge.mat');

clf; hold on;

plot(x_train, y_train, 'x');
plot(x_test, y_test, 'o');

l_exp = -15:8;
err=zeros(length(l_exp), 1);

n = 20;
cv = cvpartition(n,'kfold',10);

for it = 1:cv.NumTestSets
    train_index = cv.training(it);
    test_index = cv.test(it);
end


for it=1:length(l_exp);
    c = (it - 1)/length(l_exp);
    color = [c 0 1-c];
    % lambda runs from blue (small) to red (big)
    err(it) = doRidge(x_train, y_train, x_test, y_test, 2^l_exp(it), color);
end

figure
plot(l_exp, err);

%%

clf; hold on;

plot(x_train, y_train, 'x');

doRidge(x_train, y_train, x_test, y_test, 0.0001, 'g');
doRidge(x_train, y_train, x_test, y_test, 0.1, 'r');
doRidge(x_train, y_train, x_test, y_test, 10, 'k');