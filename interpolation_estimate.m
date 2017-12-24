function [rotate_estimate, resize_estimate, F, B] = interpolation_estimate(imr_hey, delta, W, T, show)
    if size(imr_hey, 3) == 3
        imr = rgb2gray(imr_hey);
    else
        imr = imr_hey;
    end

    filter = fspecial('laplacian', 0);
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
            inrange = 1;
            for k = -delta : delta
                if j + k <= 0 || j + k > width
                    inrange = 0;
                end
                if j + k > 0 && j + k <= width && k ~= 0
                    if abs(rowf(j + k)) > abs(rowf(j))
                        flag = 0;
                    end
                end
            end
            if inrange == 1
                c(j) = c(j) + flag;
            end
        end
    end

    dft_average = rowf_sum ./ height;
    average_dft = abs(fft(mean(imf, 1)));
    AD_records = peak_detection_AD(average_dft, 5, 0.05);

    records = peak_detection(c, W, T);

    if show == 1
        subplot(4,2,[2,4,6,8])
        imshow(imr_hey)

        subplot(4,2,1)
        plot([2: width] ./ width, abs(dft_average(2:end)))

        subplot(4,2,3)
        plot([2: width] ./ width, abs(average_dft(2:end)))

        ax = subplot(4,2,5);
        bar([2: width] ./ width, c(2:end))
        xlim(ax, [0, 1])

        ax = subplot(4,2,7);
        bar([1: size(AD_records, 1) * 2] ./ width, [AD_records; flip(AD_records, 1)])
        xlim(ax, [0, 1])
    elseif show == 2
        subplot(1,2,2)
        imshow(imr_hey)
        subplot(1,2,1)
        plot([2: width] ./ width, abs(dft_average(2:end)))
    elseif show == 3
        subplot(4,2,[2,4,6])
        imshow(imr_hey)
        
        subplot(4,2,1)
        plot([2: width] ./ width, abs(dft_average(2:end)))

        subplot(4,2,3)
        plot([2: width] ./ width, abs(average_dft(2:end)))

        ax = subplot(4,2,5);
        bar([2: width] ./ width, c(2:end))
        xlim(ax, [0, 1])

        ax = subplot(4,2,7);
        bar([1: size(AD_records, 1) * 2] ./ width, [AD_records; flip(AD_records, 1)])
        xlim(ax, [0, 1])
    end

    [B, I] = sort(records, 'descend');
    F = I ./ width;
    B = B ./ height;

    counting_thres = 0.20;
    if B(1) >= counting_thres
        if AD_records(I(1)) == 0
            resize_estimate = [0, 0, 0];
            if B(2) >= counting_thres && B(2)/B(3) >= 1.1
                f1 = min(F(1), F(2));
                f2 = max(F(1), F(2));
                rotate_estimate = [acosd(1 - f1), asind(f2)];

                if abs(rotate_estimate(1) - rotate_estimate(2)) > 3 && rotate_estimate(1) > 29
                    % may result from rotaion angle > 30)
                    rotate_estimate(2) = asind(1 - f2);
                end
            else
                % may result from angle too small
                % which makes peak f1 too small to be found
                f2 = F(1);
                rotate_estimate = [nan, asind(f2)];
            end
        else
            rotate_estimate = [0, 0];
            f_int = F(1);
            resize_estimate = [1/(1-f_int), 1/f_int, 1/(1+f_int)];
        end
    else
        rotate_estimate = [0, 0];
        resize_estimate = [0, 0, 0];
    end
    
    if show == 3
        delete(subplot(4,2,8))
        ax = subplot(4,2,8);
        set(ax,'visible','off');
        t1 = text(0, 0, sprintf('Eestimated resize factor: %.3f, %.3f, %.3f\n', resize_estimate(3), resize_estimate(1:2)), 'fontsize', 18);
        t2 = text(0, 0.5, sprintf('Estimated rotate angle: %.3f, %.3f\n', rotate_estimate), 'fontsize', 18);
        set(t1,'visible','on')
        set(t2,'visible','on')
%         
%         h = title(sprintf('Rotated by %d degree (bilinear)', angle), 'FontSize', 20);
%         set(h,'visible','on')
    end

end

