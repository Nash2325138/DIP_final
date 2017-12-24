close all
clear

imr = imread('./pic/spliced/street_pepper.tiff');
% record = test_rotation(imr, 0.1);
% record = test_resizing(imr, 0.1);

B = 128;
L = 32;

Ts_ratio = [0.13];
suspiciousGraphs = forgeryDetection(imr, B, L, Ts_ratio, 0);

figure
rect_suspicious(imr, squeeze(suspiciousGraphs(1, :, :)), B, L);

% delta = 5;
% W = 2;
% T = 2;
% show = 3;

% figure('pos',[10 10 1200 400])
% imr_rotate = imRotateCrop(imr, 23, 'bilinear');
% [rotate_estimate, resize_estimate, I, B] = interpolation_estimate(imr_rotate, delta, W, T, show);
% 
% figure('pos',[10 10 1200 400])
% imr_resize = imresize(imr, 2.3, 'bilinear');
% [rotate_estimate, resize_estimate, I, B] = interpolation_estimate(imr_resize, delta, W, T, show);
%         
