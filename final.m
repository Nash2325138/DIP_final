close all
clear
imr = imread('./pic/bridge.tiff');
% imr = rgb2gray(imr);
% imr = imRotateCrop(imr, 24, 'bilinear');
% imr = imresize(imr, 4.3, 'bilinear');

% delta = 5;
% W = 2;
% T = 2;
% show = 1;
% [output, I, B] = interpolation_estimate(imr, delta, W, T, show);
% I(1:5), B(1:5)
% output

test_rotation(imr);