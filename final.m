close all
clear
imr = imread('./pic/boat.tiff');
% imr = rgb2gray(imr);
% imr = imRotateCrop(imr, 26, 'bilinear');
imr = imresize(imr, 3, 'bilinear');

delta = 5;
W = 2;
T = 2;
[output, I, B] = interpolation_estimate(imr, delta, W, T);

I(1:5), B(1:5)
output