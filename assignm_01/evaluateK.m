function [ minK, errValue ] = evaluateK( train_data, train_label, test_data, test_label )
%EVALUATEK evaluates knnClassify for different k-values and returns the
%minimal k

%% Section 6
k_values = [1 3 5 7 10 15 20];
error_test = zeros(1, length(k_values));
error_train = zeros(1, length(k_values));
for it = 1:length(k_values)
    disp(['Working on test data for k=' int2str(k_values(it))]);
    tic
    test_pred_label = knnClassify(train_data, train_label, test_data, k_values(it));
    error_test(it) = loss01(test_pred_label, test_label);
    toc
    
    disp(['Working on training data for k=' int2str(k_values(it))]);
    tic
    train_pred_label = knnClassify(train_data, train_label, train_data, k_values(it));
    error_train(it) = loss01(train_pred_label, train_label);
    toc
end

%% Section 7

figure(2); clf; hold all;
plot(k_values,error_test,'r*:');
plot(k_values,error_train,'b.-');


%% Section 8
[sorted, index] = sort(error_test);
minK = k_values(index(1));
errValue=sorted(1);

end

