function records = peak_detection(c, W, T)
    half_width = floor(size(c, 1)/2);
    half_c = c(1:half_width);

    records = zeros([half_width, 1]);
    for i = 1 : half_width
        if i - W > 0 && i + W <= half_width
            part = half_c(i - W:i + W);
            cmp = median(part);
            % cmp = sort(part, 'descend');
            % cmp = cmp(2);
            if half_c(i) - cmp > T
                records(i) = c(i);
            end
        end
    end
end

