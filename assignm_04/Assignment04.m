%% Exercise 1
% copied from Assignment 1 Exercise 2
load('usps_train.mat');
load('usps_test.mat');
%% Section 1
trList = find(train_label==4 | train_label==9);
x_train = double(train_data(trList,:));
y_train = double(train_label(trList));

testList = find(test_label==4 | test_label==9);
x_test = double(test_data(testList,:));
y_test = double(test_label(testList));
% end of copy

cls = ClassificationDiscriminant.fit(x_train, y_train);

% display of the linear coefficients for predicting the class
dig = reshape(cls.Coeffs(1,2).Linear,16,16);
imagesc(dig)

%% Section 2

% positive values indicate class 1 (4) negative class 2 (9), we take the
% sign to predict the class
pred_test = sign(evaluateCls(cls, 1, 2, x_test));

% the real y-values are converted to -1 and 1 and compared to our
% predictions
loss01(pred_test, (y_test==4)-(y_test==9))

%% Exercise 2

trList = find(train_label==4 | train_label==3 | train_label==2 | train_label==1);
x_train = double(train_data(trList,:));
y_train = double(train_label(trList));

testList = find(test_label==4 | test_label==3 | test_label==2 | test_label==1);
x_test = double(test_data(testList,:));
y_test = double(test_label(testList));

%% one vs. all
cls1 = ClassificationDiscriminant.fit(x_train, y_train==1);
cls2 = ClassificationDiscriminant.fit(x_train, y_train==2);
cls3 = ClassificationDiscriminant.fit(x_train, y_train==3);
cls4 = ClassificationDiscriminant.fit(x_train, y_train==4);

weights = zeros(length(x_test), 4);
weights(:,1) = evaluateCls(cls1, 1, 2, x_test);
weights(:,2) = evaluateCls(cls2, 1, 2, x_test);
weights(:,3) = evaluateCls(cls3, 1, 2, x_test);
weights(:,4) = evaluateCls(cls4, 1, 2, x_test);

[~,pred] = min(weights,[], 2);

% the real y-values are converted to -1 and 1 and compared to our
% predictions
loss01(pred, y_test)

%% one vs. one

clsX = ClassificationDiscriminant.fit(x_train, y_train);

weights = zeros(3, 3, length(x_test));

for a=1:3
    for b=(a+1):4
        weights(a, b - 1, :) = evaluateCls(clsX, a, b, x_test);
    end
end

pred = zeros(length(x_test), 1);

for it=1:length(x_test)
    slice = abs(weights(:,:,it));
    [~, index] = max(slice(:));
    index2 = floor((index - 1) / 3) + 1;
    index1 = mod((index - 1), 3) + 1;
    if weights(index1, index2, it)>0
        pred(it) = index1;
    else
        pred(it) = index2 + 1;
    end
end

loss01(pred, y_test)