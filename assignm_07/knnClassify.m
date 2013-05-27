function closest_labels = knnClassify( train_data, train_label, test_data )
%KNNCLASSIFY Uses k-nearest neighbours method to predict labels
% assumes labels to be either 1 or 0

% Berechnung nach der Formel d^2 = a'*a + b'*b - 2*a'*b
% a'*a
train_scalars = sum(train_data.^2,2)*ones(size(test_data,1),1)';
% b'*b
test_scalars = ones(size(train_data,1),1)*sum(test_data.^2,2)';
% putting things together
distances = sqrt(train_scalars+test_scalars-2*train_data*test_data');
[~,index] = sort(distances, 1);
closest_labels = train_label(index)';

end

