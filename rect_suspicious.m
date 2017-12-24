function rect_suspicious(image, suspiciousGraph, B, L)
    [height, width] = size(image);
%     bh = ceil((height - B) / L); 
%     bw = ceil((width - B) / L);
    [bh, bw] = size(suspiciousGraph);
    imshow(image);
    for i = 1 : bh
        for j = 1 : bw
            if suspiciousGraph(i, j) == 1
                x = (i - 1) * L + 1;
                y = (j - 1) * L + 1;
                rectangle('Position', [y, x, B, B], ...
                        'EdgeColor', 'red', ...
                        'LineWidth', 1.5);
            end
        end
    end
end

