function [ x_train, y_train, x_test, y_test ] = loadCancerData(  )
%LOADCANCERDATA Loads the cancerdata set and returns train/testdata

load('cancer-data.mat');

x_train = cancerInput_train;
y_train = cancerTarget_train;

x_test = cancerInput_test;
y_test = cancerTarget_test;

end

