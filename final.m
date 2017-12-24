close all
clear

imr = imread('./pic/bridge.tiff');
if size(imr, 3) == 3
    imr = rgb2gray(imr);
end
% record = test_rotation(imr, 0.1);
% record = test_resizing(imr, 0.1);

% forgeryDetection(imr, 64, 16)

delta = 5;
W = 2;
T = 2;
show = 1;

figure
imr_rotate = imRotateCrop(imr, 23, 'bilinear');
[rotate_estimate, resize_estimate, I, B] = interpolation_estimate(imr_rotate, delta, W, T, show);

figure
imr_resize = imresize(imr, 2.3, 'bilinear');
[rotate_estimate, resize_estimate, I, B] = interpolation_estimate(imr_resize, delta, W, T, show);
        
