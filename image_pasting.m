clear
close all
spliced = imread('./pic/street1.tif');
obj = imread('./pic/material/pepper_crop.tiff');
obj = cast(obj, 'uint16');
% obj = imrotate(obj, 23, 'bilinear');
obj = imresize(obj, 2.3, 'bilinear');

x_st = 800;
y_st = 1100;
for x = 1:size(obj, 1)
    for y = 1:size(obj, 2)
        if obj(x, y, 4) ~= 0
            spliced(x_st + x, y_st + y, :) = obj(x, y, 1:3) * 256;
        end
    end
end

% imwrite(spliced, './pic/spliced/street_pepper.tiff')
imshow(spliced);


figure
spliced = rgb2gray(spliced);
imshow(spliced);

figure
forgeryDetection(spliced, 128, 32)

