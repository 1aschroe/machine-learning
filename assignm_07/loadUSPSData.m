function [ x_train, y_train, x_test, y_test ] = loadUSPSData(  )
%LOADUSPS Summary of this function goes here
%   Detailed explanation goes here

load('usps_train.mat');
x_train = double(train_data);
y_train = train_label;
load('usps_test.mat');
x_test = double(test_data);
y_test = test_label;

end

