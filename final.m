close all
clear
imr = imread('./pic/boat.tiff');
% imr = rgb2gray(imr);
imr = imRotateCrop(imr, 26, 'bicubic');
% imr = imresize(imr, 2.3, 'bilinear');
[output, I, B] = interpolation_estimate(imr);

I(1:5), B(1:5)
output