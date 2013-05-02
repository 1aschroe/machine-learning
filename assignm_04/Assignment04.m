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

%% one vs. all
% Each classifier gets trained for one class, so cls1 classifies for 1 and !1, cls2
% for !2 and so on.
cls1 = ClassificationDiscriminant.fit(x_train, y_train==1);
cls2 = ClassificationDiscriminant.fit(x_train, y_train==2);
cls3 = ClassificationDiscriminant.fit(x_train, y_train==3);
cls4 = ClassificationDiscriminant.fit(x_train, y_train==4);

% All weights for the testdata are collected from each classifier.
% The data is written in a 200x4 matrix.
weights = zeros(length(x_test), 4);
weights(:,1) = evaluateCls(cls1, 1, 2, x_test);
weights(:,2) = evaluateCls(cls2, 1, 2, x_test);
weights(:,3) = evaluateCls(cls3, 1, 2, x_test);
weights(:,4) = evaluateCls(cls4, 1, 2, x_test);

% min returns the smalles row entry of the weight matrix
% pred_labels holds the indexes of the columns which are fortunately our labels
[~,pred_labels] = min(weights,[], 2);

% We compare the predicted labels with the reference labels to generate our
% loss
one_vs_all = loss01(pred_labels, y_test)

%% one vs. one
% for one vs. one we train our classifier with all labels (i.e. it has four
% classes to distinguish)
clsX = ClassificationDiscriminant.fit(x_train, y_train);

% Our weights are stored in a 400x6 matrix, where each column represents a 
% unique pair of classes:
classRef = [1 2; 1 3; 1 4; 2 3; 2 4; 3 4];
weights = zeros(length(x_test), 6);

% iterate over class combinations and generate weights
for it=1:length(classRef)
    classA = classRef(it, 1);
    classB = classRef(it, 2);
    weights(:,it) = evaluateCls(clsX, classA, classB, x_test);
end

pred_labels = zeros(length(x_test), 1);
% for each row find the maximum absolute value and put it into the
% predtiction data
for it=1:length(x_test)
    % find absolute max value
    [val_pos, max_pos] = max(weights(it, :));
    [val_neg, max_neg] = max(weights(it, :)*-1);
    if(val_pos > val_neg)
        % reference first class if max value was positive (classA)
        pred_labels(it) = classRef(max_pos, 1);
    else
        % reference second class if max value was negative (classB)
        pred_labels(it) = classRef(max_neg, 2);
    end
end

one_vs_one = loss01(pred_labels, y_test)