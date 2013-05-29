function [ pred_labels ] = clsOneVsAll( x_train, y_train, x_test )
%CLSONEVSALL Summary of this function goes here
%   Detailed explanation goes here

y_values = unique(y_train);

%% one vs. all
% Each classifier gets trained for one class, so cls1 classifies for 1 and !1, cls2
% for !2 and so on.
weights = zeros(length(x_test), length(y_values));
for it=1:length(y_values)
    y_value=y_values(it);
    if size(find(y_train==y_value),1) ~= 0
        cls = ClassificationDiscriminant.fit(x_train, y_train==y_value);
        % All weights for the testdata are collected from each classifier.
        % The data is written in a 200x4 matrix.
        weights(:,it) = evaluateCls(cls, 1, 2, x_test);
    end
end

% min returns the smalles row entry of the weight matrix
% pred_labels holds the indexes of the columns
[~,pred_label_indices] = min(weights,[], 2);

pred_labels = y_values(pred_label_indices);

end

