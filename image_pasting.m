% clear
close all
spliced = imread('./pic/street1.tif');
obj = imread('./pic/material/sit_man_small.png');
obj = cast(obj, 'uint16');
% obj = rgb2gray(obj);

% obj = imrotate(obj, 38, 'bilinear');
obj = imresize(obj, 2.8, 'bilinear');
paste_mask = zeros([size(spliced, 1), size(spliced, 2)]);
x_st = 1000;
y_st = 1850;
for x = 1:size(obj, 1)
    for y = 1:size(obj, 2)
        if any(obj(x, y, :) > 1)
            spliced(x_st + x, y_st + y, 1:3) = obj(x, y, 1:3) * 256;
            paste_mask(x_st + x, y_st + y) = 1;
        end
    end
end

% imwrite(spliced, './pic/spliced/street_car.tiff')
imshow(spliced);
figure
imshow(paste_mask);

% figure
spliced_gray = rgb2gray(spliced);
% imshow(spliced_gray);
% 
% 
B = 128;
L = 32;
should_be_marked = zeros([ceil((size(paste_mask,1) - B) / L), ceil((size(paste_mask, 2) - B) / L)]);
size(should_be_marked)
for i = 1:size(should_be_marked, 1)
    for j = 1:size(should_be_marked, 2)
        counting = 0;
        for x = 1:B
            for y = 1:B
                if paste_mask(uint16((i-1)*L) + x, uint16((j-1)*L) + y) > 0
                    counting = counting + 1;
                end
            end
        end
        if counting > B*B*0.7
            should_be_marked(i, j) = 1;
        end
    end
end
figure
rect_suspicious(spliced, should_be_marked, B, L);
% Ts_ratio = [0.2, 0.24, 0.28];
% suspiciousGraphs = forgeryDetection(spliced_gray, B, L, Ts_ratio, 0);
% figure
% rect_suspicious(spliced, squeeze(suspiciousGraphs(1, :, :)), B, L);
