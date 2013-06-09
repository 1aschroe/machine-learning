function [ V, D ] = PCA( data )
%PCA Summary of this function goes here
%   Detailed explanation goes here

centeredData = data - repmat(mean(data),[size(data,1) 1]);
C = cov(centeredData);
[V, D] = eig(C);

end