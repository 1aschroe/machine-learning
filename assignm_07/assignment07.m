
%[x_train, y_train, x_test, y_test] = loadShuttleData();

[x_train, y_train, x_test, y_test] = loadCancerData();

pred_labels = clsOneVsOne(x_train, y_train, x_test);

err_OneVsOne = loss01(pred_labels, y_test)

pred_labels = clsOneVsAll(x_train, y_train, x_test);

err_OneVsAll = loss01(pred_labels, y_test)

[~, err_kNN] = evaluateK(x_train, y_train, x_test, y_test)