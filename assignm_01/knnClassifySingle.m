function pred = knnClassifySingle( train_data, train_label, test_datum, k )
%KNNCLASSIFY Uses k-nearest neighbours method to predict label of single
%datum
% assumes labels to be either 1 or 0

distances = sqrt(sum((train_data - ones(size(train_data,1),1)*test_datum).^2,2));
[sorted,index] = sort(distances);
closest_labels = train_label(index);

pred = mode(closest_labels(1:k));

end