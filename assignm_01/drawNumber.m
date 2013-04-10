function [  ] = drawNumber( train_data )
%DRAWNUMBER Summary of this function goes here
%   Detailed explanation goes here

figure;
element = randi(size(train_data,1),1);
dig = reshape(train_data(element,:),16,16);
imagesc(dig)
colormap('gray');

end

