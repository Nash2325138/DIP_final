function forgeryDetection(image, B, L)

delta = 5;
W = 2;
T = 2;
show = 0;

[height, width] = size(image);

for i = 1 : L : height - B
    for j = 1 : L : width - B
        subim = image(i:i + B, j:j + B);
        [rotate_estimate, resize_estimate, ~, ~] = interpolation_estimate(subim, delta, W, T, show);
        if rotate_estimate(1) ~= 0 && rotate_estimate(2) ~= 0
            [rotate_estimate, resize_estimate, ~, ~] = interpolation_estimate(subim, delta, W, T, show);
            disp(rotate_estimate);
            pause;
        end
        % disp(resize_estimate);
    end
end

end

