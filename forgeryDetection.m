function forgeryDetection(image, B, L)

delta = 5;
W = 2;
Ts = [B * 0.05, B * 0.07, B * 0.08, B * 0.12];
show = 0;

[height, width] = size(image);
bh = floor((height - B) / L);
bw = floor((width - B) / L);

for ti = 1 : size(Ts, 2)
    suspiciousGraph = zeros([bh, bw]);
    bin_top_freq_a = zeros([bh, bw]);
    bin_top_freq_b = zeros([bh, bw]);
    freq_counter = zeros([1000, 1]);

    for i = 1 : L : height - B
        for j = 1 : L : width - B
            subim = image(i:i + B, j:j + B);
            sidx = (i - 1) / L + 1;
            sidy = (j - 1) / L + 1;
            [rotate_estimate, resize_estimate, freq, magn] = interpolation_estimate(subim, delta, W, Ts(ti), show);
            rt1 = rotate_estimate(1);
            rt2 = rotate_estimate(2);
            if ~isnan(rt1) && ~isnan(rt2)
                if rt1 ~= 0 && rt2 ~= 0
                    fa = floor(freq(1) * 1000);
                    fb = floor(freq(2) * 1000);
                    freq_counter(fa) = freq_counter(fa) + 1;
                    freq_counter(fb) = freq_counter(fb) + 1;
                    bin_top_freq_a(sidx, sidy) = fa;
                    bin_top_freq_b(sidx, sidy) = fb;
                end
            elseif isnan(rt1) && ~isnan(rt2)
                if rt2 ~= 0
                    f = floor(freq(1) * 1000);
                    freq_counter(f) = freq_counter(f) + 1;
                    bin_top_freq_a(sidx, sidy) = f;
                    bin_top_freq_b(sidx, sidy) = f;
                end
            end
            re1 = resize_estimate(1);
            re2 = resize_estimate(2);
            re3 = resize_estimate(3);
            if re1 ~= 0 || re2 ~= 0 || re3 ~= 0
                f = floor(freq(1) * 1000);
                freq_counter(f) = freq_counter(f) + 1;
                bin_top_freq_a(sidx, sidy) = f;
                bin_top_freq_b(sidx, sidy) = f;
            end
        end
    end

    [~, globmaxfreq] = sort(freq_counter, 'descend');
    globmaxfreq = globmaxfreq(1:2);

    for i = 1 : bh
        for j = 1 : bw
            if bin_top_freq_a(i, j) == globmaxfreq(1) || ...
                bin_top_freq_a(i, j) == globmaxfreq(2) || ...
                bin_top_freq_b(i, j) == globmaxfreq(1) || ...
                bin_top_freq_b(i, j) == globmaxfreq(2)
                suspiciousGraph(i, j) = 1;
            end
        end
    end

    for i = 1 : bh
        for j = 1 : bw
            if suspiciousGraph(i, j) == 1 && hasneighbors(suspiciousGraph, bin_top_freq_a, bin_top_freq_b, i, j) == 0
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
                        'LineWidth', 1.5);
            end
        end
    end
end

end

