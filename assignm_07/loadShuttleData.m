function [ x_train, y_train, x_test, y_test ] = loadShuttleData(  )
%LOADSHUTTLEDATA Summary of this function goes here
%   Detailed explanation goes here

%%Load shuttle data

% using StatLog Shuttle data:
% http://archive.ics.uci.edu/ml/datasets/Statlog+%28Shuttle%29
load('shuttle.trn');
% Shuttle dataset has 9 entries
x=shuttle(:,1:9);
% tenth column defines class
y=shuttle(:,10);

% define amount of train and testdata
train_size = 5000;
test_size = 500;

% create random indices for the retrievel of the datased
indices = randsample(size(x,1),train_size + test_size);
% Retrieve random test and traindata from the dataset
x_train=x(indices(1:train_size),:);
y_train=y(indices(1:train_size));
x_test=x(indices((train_size+1):(train_size + test_size)),:);
y_test=y(indices((train_size+1):(train_size + test_size)));

end

