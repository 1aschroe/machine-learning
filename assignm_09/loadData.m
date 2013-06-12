function [ X, Y ] = loadData( )
%LOADDATA Loads the USPS Dataset and extracts all 1, 3, 4, 6.
%Returns X = traindata, Y = trainlabels

[x_train, y_train, ~, ~] = loadUSPSData();

sampleSize = 200;
digits = [1 3 4 6];
samples = zeros(length(digits)*sampleSize, 1);
for digit = digits
    indices = randsample(length(find(y_train==digit)), sampleSize);
    digitIndex = find(digits==digit);
    samples((digitIndex - 1)*sampleSize + 1 : digitIndex*sampleSize) = ...
        indices + find(y_train==digit, 1 ) - 1;
end

X = x_train(samples, :);
Y = y_train(samples);
end

