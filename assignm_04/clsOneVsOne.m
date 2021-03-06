function [ pred_labels ] = clsOneVsOne( x_train, y_train, x_test, classRef )
%CLSONEVSONE Summary of this function goes here
%   Detailed explanation goes here

%% one vs. one
% for one vs. one we train our classifier with all labels (i.e. it has four
% classes to distinguish)
clsX = ClassificationDiscriminant.fit(x_train, y_train);

% iterate over class combinations and generate weights
weights = zeros(length(x_test), length(classRef));
for it=1:length(classRef)
    classA = classRef(it, 1);
    classB = classRef(it, 2);
    weights(:,it) = evaluateCls(clsX, classA, classB, x_test);
end

pred_labels = zeros(length(x_test), 1);
% for each row find the maximum absolute value and put it into the
% prediction data
for it=1:length(x_test)
    % find absolute max value
    [val_max_pos, index_max_pos] = max(weights(it, :));
    [val_max_neg, index_max_neg] = max(weights(it, :)*-1);
    if(val_max_pos > val_max_neg)
        % reference first class if max value was positive (classA)
        pred_labels(it) = classRef(index_max_pos, 1);
    else
        % reference second class if max value was negative (classB)
        pred_labels(it) = classRef(index_max_neg, 2);
    end
end

end

