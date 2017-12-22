function records = peak_detection(c, W, T)
    half_width = floor(size(c, 1)/2);
    half_c = c(1:half_width);

    records = zeros([half_width, 1]);
    for i = 1 : half_width
        if i - W > 0 && i + W <= half_width
            part = half_c(i - W:i + W);
            med = median(part);
            if half_c(i) - med > T
                records(i) = c(i);
            end
        end
    end
end

