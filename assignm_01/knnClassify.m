function pred = knnClassify( train_data, train_label, test_data, k )
%KNNCLASSIFY Uses k-nearest neighbours method to predict labels
% assumes labels to be either 1 or 0

pred = zeros(1,length(test_data));
for it = 1:length(test_data)
    pred(it) = knnClassifySingle(train_data, train_label, test_data(it,:), k);
end

end

