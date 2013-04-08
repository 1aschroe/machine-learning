function pred = knnClassify( train_data, train_label, test_data, k )
%KNNCLASSIFY Uses k-nearest neighbours method to predict labels
% assumes labels to be either 1 or 0

pred = knnClassifySingle(train_data, train_label, test_data, k);

end

