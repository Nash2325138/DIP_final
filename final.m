close all
clear

imr = imread('./pic/rotation_pair/000/spliced.jpg');
if size(imr, 3) == 3
    imr_gray = rgb2gray(imr);
else
    imr_gray = imr;
end
% record = test_rotation(imr, 0.1);
% record = test_resizing(imr, 0.1);

B = 32;
L = 8;

Ts_ratio = [0.18, 0.2, 0.23];
suspiciousGraphs = forgeryDetection(imr_gray, B, L, Ts_ratio, 0);

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
