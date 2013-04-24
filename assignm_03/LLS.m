function [ w ] = LLS( x, y )
%As given in the Exercise lecture, this function computes the output w of
%given input matrices x and y.

w = (x'*x)\(x'*y);

end