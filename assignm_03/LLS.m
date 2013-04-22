function [ w ] = LLS( x, y )
%LLS Summary of this function goes here
%   Detailed explanation goes here

w = (x'*x)\(x'*y);

end