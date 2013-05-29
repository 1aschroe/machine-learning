function [ pred_labels ] = clsOneVsOne( x_train, y_train, x_test )
%CLSONEVSONE Summary of this function goes here
%   Detailed explanation goes here

%% one vs. one
% for one vs. one we train our classifier with all labels (i.e. it has four
% classes to distinguish)
clsX = ClassificationDiscriminant.fit(x_train, y_train);

% The cartesian product of the values in y_train
% with each other (unique(y_train) x unique(y_train))
[x, y] = meshgrid(1:size(unique(y_train), 1));
cartesian = [x(:) y(:)];
% From this we select only those entrys where the first component is
% smaller than the second one
classRef = cartesian(cartesian(:,1) < cartesian(:,2),:);

% iterate over class combinations and generate weights
weights = zeros(length(x_test), size(classRef, 1));
for it=1:size(classRef, 1)
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
        pred_labels(it) = clsX.ClassNames(classRef(index_max_pos, 1));
    else
        % reference second class if max value was negative (classB)
        pred_labels(it) = clsX.ClassNames(classRef(index_max_neg, 2));
    end
end

end

