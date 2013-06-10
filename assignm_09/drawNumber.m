function [  ] = drawNumber( element )
%DRAWNUMBER Summary of this function goes here
%   Detailed explanation goes here

figure;
dig = reshape(element,16,16);
imagesc(dig)
colormap('gray');

end

