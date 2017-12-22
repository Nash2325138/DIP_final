close all
clear
imr = imread('./pic/boat.tiff');
% imr = rgb2gray(imr);
imr = imRotateCrop(imr, 40, 'bicubic');
% imr = imresize(imr, 2.3, 'bilinear');

filter = fspecial('laplacian');
imf = imfilter(imr, filter);

height = size(imr, 1);
width = size(imr, 2);

c = zeros(width, 1);

rowf_sum = zeros(width, 1).';

for i = 1 : height
    row = imf(i, :);
    rowf = fft(row);
    rowf_sum = rowf_sum + abs(rowf);
    for j = 1 : width
        flag = 1;
        for k = -5 : 5
            if j + k > 0 && j + k <= width && k ~= 0
                if abs(rowf(j + k)) > abs(rowf(j))
                    flag = 0;
                end
            end
        end
        c(j) = c(j) + flag;
    end
end

rowf_sum = rowf_sum ./ height;
subplot(3,1,1)
plot([2: width] ./ width, abs(rowf_sum(2:end)))

subplot(3,1,2)
temp = fft(mean(imf, 1));
plot([2: width] ./ width, abs(temp(2:end)))

ax = subplot(3,1,3);
bar([2: width] ./ width, c(2:end))
xlim(ax, [0, 1])

half_width = floor(size(c, 1)/2);
half_c = c(1:half_width);


records = zeros([width, 1]);
W = 2;
T = 2;
for i = 1 : half_width
    if i - W > 0 && i + W <= half_width
        part = half_c(i - W:i + W);
        med = median(part);
        if half_c(i) - med > T
            records(i) = c(i);
        end
    end
end

[B, I] = sort(records, 'descend');
I = I ./ width;

I(1:5), B(1:5)
a = I(1);
b = I(2);
disp(acosd(1 - a));
disp(asind(b));

disp(1/a)
