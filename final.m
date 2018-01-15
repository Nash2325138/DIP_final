close all
clear


% -------------------- Algorithm 1 test -------------------- %
% imr = imread('./pic/bridge.tiff');
% if size(imr, 3) == 3
%     imr_gray = rgb2gray(imr);
% else
%     imr_gray = imr;
% end
% record = test_rotation(imr, 0.1);
% record = test_resizing(imr, 0.1);

% -------------------- Algorithm 2 test -------------------- %
spliced = imread('./pic/street1.tif');
obj = imread('./pic/material/sit_man_small.png');
obj = cast(obj, 'uint16');

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

imshow(spliced);
title('Spliced image')

figure
imshow(paste_mask);
title('Splicing mask')

spliced_gray = rgb2gray(spliced);

B = 128;
L = 32;
should_be_marked = zeros([ceil((size(paste_mask,1) - B) / L), ceil((size(paste_mask, 2) - B) / L)]);
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
title('Those blocks that contains > 70% of pasted pixels')

Ts_ratio = [0.2, 0.24, 0.28];
suspiciousGraphs = forgeryDetection(spliced_gray, B, L, Ts_ratio, 0);
figure

for i = 1:size(Ts_ratio, 2)
    figure
    paras_str = sprintf('B=%d, L=%d, T ratio=%.2f', B, L, Ts_ratio(i));
    rect_suspicious(spliced, squeeze(suspiciousGraphs(i, :, :)), B, L);
    title(paras_str)
    fprintf('\nThe scores of %s:\n', paras_str);
    print_scores(should_be_marked, squeeze(suspiciousGraphs(i,:,:)))
end