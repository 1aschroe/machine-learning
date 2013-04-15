function pred = knnClassify( train_data, train_label, test_data, k )
%KNNCLASSIFY Uses k-nearest neighbours method to predict labels
% assumes labels to be either 1 or 0

pred = zeros(size(test_data, 1),1);
for it = 1:size(test_data, 1)
    pred(it) = knnClassifySingle(train_data, train_label, test_data(it,:), k);
end

end

