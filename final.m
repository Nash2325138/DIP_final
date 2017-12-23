close all
clear
% imr = imread('./pic/tt_rotate.tiff');
% test_rotation(imr);
% test_resizing(imr);
% forgeryDetection(imr, 64, 32)

tank1 = imread('./pic/tank1.tiff');
tank2 = imread('./pic/tank2.tiff');
t1 = imread('./pic/tank1_small.tiff');
t1 = imrotate(t1, 23, 'bilinear');

x_st = 50;
y_st = 300;
for x = 1:size(t1, 1)
    for y = 1:size(t1, 2)
        if t1(x, y) > 0
            tank2(x_st + x, y_st + y) = t1(x, y);
        end
    end
end
forgeryDetection(tank2, 64, 16)
% imwrite(tank2, 'pic/tt_rotate.tiff')

