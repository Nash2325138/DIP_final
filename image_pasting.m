clear
close all
spliced = imread('./pic/street1.tif');
obj = imread('./pic/material/sit_man_small.png');
obj = cast(obj, 'uint16');
% obj = rgb2gray(obj);

% obj = imrotate(obj, 38, 'bilinear');
obj = imresize(obj, 2.8, 'bilinear');

x_st = 1000;
y_st = 1850;
for x = 1:size(obj, 1)
    for y = 1:size(obj, 2)
        if any(obj(x, y, :) > 1)
            spliced(x_st + x, y_st + y, 1:3) = obj(x, y, 1:3) * 256;
        end
    end
end

% imwrite(spliced, './pic/spliced/street_car.tiff')
imshow(spliced);

figure
spliced_gray = rgb2gray(spliced);
imshow(spliced_gray);


B = 128;
L = 32;
Ts_ratio = [0.2, 0.24, 0.28];
suspiciousGraphs = forgeryDetection(spliced_gray, B, L, Ts_ratio, 0);
figure
rect_suspicious(spliced, squeeze(suspiciousGraphs(1, :, :)), B, L);
