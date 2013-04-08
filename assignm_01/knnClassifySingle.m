function pred = knnClassifySingle( train_data, train_label, test_datum, k )
%KNNCLASSIFY Uses k-nearest neighbours method to predict label of single
%datum
% assumes labels to be either 1 or 0


%FIXME: Hier müsste man das halt hinbekommen, dass der Vektor test_datum
%von jedem train_datum abgezogen wird.
distances = sqrt(sum((train_data - ones(size(train_data,1),1)*test_datum).^2,2));
[sorted,index] = sort(distances);
closest_labels = train_label(index);
label_sum = 0;
for it = 1:k
    label_sum = label_sum + closest_labels(it);
end

if label_sum / k < 1.5
    pred = 1;
else
    pred = 2;
end

end