function [ pred_labels ] = clsOneVsAll( x_train, y_train, x_test )
%CLSONEVSALL Summary of this function goes here
%   Detailed explanation goes here

classNo = max(y_train);

%% one vs. all
% Each classifier gets trained for one class, so cls1 classifies for 1 and !1, cls2
% for !2 and so on.
clsArray = cell(classNo, 1);
for it=1:classNo
    clsArray{it} = ClassificationDiscriminant.fit(x_train, y_train==it);
end

% All weights for the testdata are collected from each classifier.
% The data is written in a 200x4 matrix.
weights = zeros(length(x_test), classNo);
for it=1:classNo
    weights(:,it) = evaluateCls(clsArray{it}, 1, 2, x_test);
end

% min returns the smalles row entry of the weight matrix
% pred_labels holds the indexes of the columns which are fortunately our labels
[~,pred_labels] = min(weights,[], 2);

end

