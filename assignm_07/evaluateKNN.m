function [ min_k, err_value ] = evaluateKNN( x_train, y_train, x_test, y_test )
%EVALUATEK evaluates knnClassify for different k-values and returns the
%minimal k

[m, ~] = size(x_train);

folds = 3;
partitions = cvpartition(m,'kfold',folds);

k_values = [1 3 5 7 10 15 20];
error_test = zeros(partitions.NumTestSets, length(k_values));

for partition=1:partitions.NumTestSets
    
    x_part_train = x_train(partitions.training(partition));
    y_part_train = y_train(partitions.training(partition));
    x_part_test = x_train(partitions.test(partition));
    y_part_test = y_train(partitions.test(partition));
    
    closest_part_test_labels = knnClassify(x_part_train, y_part_train, x_part_test);
    
    for it = 1:length(k_values)
        test_pred_label = mode(closest_part_test_labels(:,1:k_values(it)),2);
        error_test(partition, it) = loss01(test_pred_label, y_part_test);
    end
end

[~, index_min_k] = min(mean(error_test,1));

min_k = k_values(index_min_k);

closest_test_labels = knnClassify(x_train, y_train, x_test);

test_pred_label = mode(closest_test_labels(:,1:min_k),2);
err_value = loss01(test_pred_label, y_test);

end

