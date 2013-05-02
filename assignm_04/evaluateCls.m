function [ pred ] = evaluateCls( cls, class1, class2, x_test )
%EVALUATECLS Takes a classifier and tests x_tests against the two annotated
%classes.
%Returns pred which is a vector containing the predicted class for each
%x_test: positive values belong to class1, negative to class2. Higher
%values indicate more confidence on the prediction.
const = cls.Coeffs(class1,class2).Const;
linear = cls.Coeffs(class1,class2).Linear;

pred = const * ones(size(x_test,1),1) + x_test * linear;

end