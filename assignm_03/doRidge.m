function [ err ] = doRidge( x_train, y_train, x_test, y_test, l , color)
%DORIDGE Summary of this function goes here
%   Detailed explanation goes here

x_for_lls = zeros(50,15);
basis_fun = cell(15,1);
for it= 1:15
    basis_fun{it} = @(x) x.^it;
    x_for_lls(:,it) = basis_fun{it}(x_train);
end

w = RidgeLLS(x_for_lls, y_train, l);

xx = -1.5:0.01:2.5;

yy = zeros(1, length(xx));
for it=1:15 
    yy = yy + w(it)*basis_fun{it}(xx);
end

plot(xx, yy, 'Color', color);

pred_test = zeros(length(x_test), 1);
for it=1:15 
    pred_test = pred_test + w(it)*basis_fun{it}(x_test);
end

err = lossL2(y_test, pred_test);
end

