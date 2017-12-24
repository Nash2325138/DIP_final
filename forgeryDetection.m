function forgeryDetection(image, B, L)

delta = 5;
W = 2;
Ts = [B * 0.05, B * 0.07, B * 0.15];
show = 0;

[height, width] = size(image);
bh = ceil((height - B) / L);
bw = ceil((width - B) / L);

counting_thres = 0.15;

drawim = image;

for ti = 1 : size(Ts, 2)
    suspiciousGraph = zeros([bh, bw]);
    drawgraph = zeros([height, width]);
    bin_top_freq_a = (-1) * ones([bh, bw]);
    bin_top_freq_b = (-1) * ones([bh, bw]);
    freq_counter = zeros([1000, 1]);

    for i = 1 : L : height - B
        for j = 1 : L : width - B
            subim = image(i:i + B, j:j + B);
            sidx = (i - 1) / L + 1;
            sidy = (j - 1) / L + 1;
            [rotate_estimate, resize_estimate, freq, magn] = interpolation_estimate(subim, delta, W, Ts(ti), show);
            if size(freq, 1) >= 2
                if magn(1) >= counting_thres
                    fa = floor(freq(1) * 1000);
                    bin_top_freq_a(sidx, sidy) = fa;
                    freq_counter(fa) = freq_counter(fa) + 1;
                    if magn(2) >= counting_thres
                        fb = floor(freq(2) * 1000);
                        bin_top_freq_b(sidx, sidy) = fb;
                        freq_counter(fb) = freq_counter(fb) + 1;
                    end
                end
            end
            if bin_top_freq_a(sidx, sidy) == 447
                drawgraph(i, j) = 1;
                drawim(i:i + B, j:j + B) = 255;
            end
            if bin_top_freq_b(sidx, sidy) == 447
                drawgraph(i, j) = 1;
                drawim(i:i + B, j:j + B) = 255;
            end
            % disp(bin_top_freq_a(sidx, sidy))
            % disp(bin_top_freq_b(sidx, sidy))
            % pause(0.5);
            % disp(rotate_estimate);
            % disp(resize_estimate);
            % pause(0.5);
            % rt1 = rotate_estimate(1);
            % rt2 = rotate_estimate(2);
            % if ~isnan(rt1) && ~isnan(rt2)
            %     if rt1 ~= 0 && rt2 ~= 0
            %         fa = floor(freq(1) * 1000);
            %         fb = floor(freq(2) * 1000);
            %         freq_counter(fa) = freq_counter(fa) + 1;
            %         freq_counter(fb) = freq_counter(fb) + 1;
            %         bin_top_freq_a(sidx, sidy) = fa;
            %         bin_top_freq_b(sidx, sidy) = fb;
            %         drawgraph(i, j) = 1;
            %     end
            % elseif isnan(rt1) && ~isnan(rt2)
            %     if rt2 ~= 0
            %         f = floor(freq(1) * 1000);
            %         freq_counter(f) = freq_counter(f) + 1;
            %         bin_top_freq_a(sidx, sidy) = f;
            %         bin_top_freq_b(sidx, sidy) = f;
            %         drawgraph(i, j) = 1;
            %     end
            % end
            % re1 = resize_estimate(1);
            % re2 = resize_estimate(2);
            % re3 = resize_estimate(3);
            % if re1 ~= 0 || re2 ~= 0 || re3 ~= 0
            %     f = floor(freq(1) * 1000);
            %     freq_counter(f) = freq_counter(f) + 1;
            %     bin_top_freq_a(sidx, sidy) = f;
            %     bin_top_freq_b(sidx, sidy) = f;
            %     drawgraph(i, j) = 1;
            % end
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
                rectangle('Position', [y, x, B, B], ...
                        'EdgeColor', 'red', ...
                        'LineWidth', 1.5);
            end
        end
    end

    for i = 1 : bh
        for j = 1 : bw
            if bin_top_freq_a(i, j) == 447
                x = (i - 1) * L + 1;
                y = (j - 1) * L + 1;
                rectangle('Position', [y, x, B, B], ...
                        'EdgeColor', 'yellow', ...
                        'LineWidth', 1.5);
            end
        end
    end

    for i = 1 : height
        for j = 1 : width
            if drawgraph(i, j) == 1
                rectangle('Position', [j, i, B, B], ...
                        'EdgeColor', 'cyan', ...
                        'LineWidth', 1.5);
            end
        end
    end
end

subplot(2, 2, 4);
imshow(drawim);

end

