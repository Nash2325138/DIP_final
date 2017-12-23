function suspiciousGraph = forgeryDetection(image, B, L)

delta = 5;
W = 2;
Ts = [B * 0.05, B * 0.07, B * 0.08];
show = 0;

[height, width] = size(image);

for ti = 1 : 3
    bh = cast((height - B) / L, 'int32');
    bw = cast((width - B) / L, 'int32');
    suspiciousGraph = zeros([bh, bw]);

    for i = 1 : L : height - B
        for j = 1 : L : width - B
            subim = image(i:i + B, j:j + B);
            [rotate_estimate, resize_estimate, ~, ~] = interpolation_estimate(subim, delta, W, Ts(ti), show);
            rt1 = rotate_estimate(1);
            rt2 = rotate_estimate(2);
            if ~isnan(rt1) && ~isnan(rt2) && rt1 ~= 0 && rt2 ~= 0
                sidx = cast((i - 1) / L + 1, 'int32');
                sidy = cast((j - 1) / L + 1, 'int32');
                suspiciousGraph(sidx, sidy) = 1;
                % [rotate_estimate, resize_estimate, ~, ~] = interpolation_estimate(subim, delta, W, T, 1);
                % disp([i, j]);
                % disp(rotate_estimate);
                % pause(1.5);
            end
        end
    end

    for i = 1 : bh
        for j = 1 : bw
            if hasneighbors(suspiciousGraph, i, j) == 0
                suspiciousGraph(i, j) = 0;
            end
        end
    end

    subplot(2, 2, ti);
    imshow(image);
    for i = 1 : bh
        for j = 1 : bw
            if suspiciousGraph(i, j) == 1
                x = (i - 1) * L + 1;
                y = (j - 1) * L + 1;
                rectangle('Position', [x, y, B, B], ...
                        'EdgeColor', 'red', ...
                        'LineWidth', 2);
            end
        end
    end
end

end

