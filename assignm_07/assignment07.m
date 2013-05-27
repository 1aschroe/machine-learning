
% using StatLog Shuttle data:
% http://archive.ics.uci.edu/ml/datasets/Statlog+%28Shuttle%29
load('shuttle.trn');
x=shuttle(:,1:9);
y=shuttle(:,10);

train_size = 5000;
test_size = 500;

indices = randsample(size(x,1),train_size + test_size);
% Retrieve 5000 random samples as training data
x_train=x(indices(1:train_size),:);
y_train=y(indices(1:train_size));
x_test=x(indices((train_size+1):(train_size + test_size)),:);
y_test=y(indices((train_size+1):(train_size + test_size)));

classRef = [1 2; 1 3; 1 4];

pred_labels = clsOneVsOne(x_train, y_train, x_test, classRef);

loss01(pred_labels, y_test)

pred_labels = clsOneVsAll(x_train, y_train, x_test);

loss01(pred_labels, y_test)

[~, errValue] = evaluateK(x_train, y_train, x_test, y_test)