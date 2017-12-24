clear
close all
spliced = imread('./pic/lake.tiff');
obj = imread('./pic/material/bird.png');
obj = cast(obj, 'uint16');
obj = imrotate(obj, 14, 'bilinear');
% obj = imresize(obj, 0.5, 'bilinear');

x_st = 50;
y_st = 400;
for x = 1:size(obj, 1)
    for y = 1:size(obj, 2)
        if obj(x, y, :) ~= 0
            spliced(x_st + x, y_st + y, :) = obj(x, y, 1:3) * 256;
        end
    end
end

% imwrite(spliced, './pic/spliced/street_plain.tiff')
imshow(spliced);

figure
spliced = rgb2gray(spliced);
imshow(spliced);


B = 64;
L = 16;
Ts_ratio = [0.12];
suspiciousGraphs = forgeryDetection(spliced, B, L, Ts_ratio, 0);
figure
rect_suspicious(spliced, squeeze(suspiciousGraphs(1, :, :)), B, L);
