function [ w ] = RidgeLLS( x, y, l )
%LLS Summary of this function goes here
%   Detailed explanation goes here

[n, d] = size(x);
w = (x'*x+n*l*eye(d))\(x'*y);

end