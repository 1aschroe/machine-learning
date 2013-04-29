function [ pred ] = evaluateCls( cls, class1, class2, x_test )
%EVALUATECLS Summary of this function goes here
%   Detailed explanation goes here

pred = cls.Coeffs(class1,class2).Const*ones(size(x_test,1),1) + x_test*cls.Coeffs(class1,class2).Linear;

end