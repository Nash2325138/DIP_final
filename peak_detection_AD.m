function records = peak_detection_AD(AD, W, ratio)
    half_width = floor(size(AD, 2) / 2);
    half_AD = AD(1:half_width);
    thres = max(AD) * ratio;
    
    records = zeros([half_width, 1]);
    for i = 1 : half_width
        if i - W > 0 && i + W <= half_width
            part = half_AD(i - W:i + W);
            maxi = max(part);
            if half_AD(i) >= maxi && half_AD(i) > thres
                records(i) = half_AD(i);
            end
        end
    end
end
