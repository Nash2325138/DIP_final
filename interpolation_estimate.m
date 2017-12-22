function [output, I, B] = interpolation_estimate(imr, delta, W, T, show)
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
            for k = -delta : delta
                if j + k > 0 && j + k <= width && k ~= 0
                    if abs(rowf(j + k)) > abs(rowf(j))
                        flag = 0;
                    end
                end
            end
            c(j) = c(j) + flag;
        end
    end

    if show == 1
        subplot(3,2,[2,4,6])
        imshow(imr)
        
        rowf_sum = rowf_sum ./ height;
        subplot(3,2,1)
        plot([2: width] ./ width, abs(rowf_sum(2:end)))

        subplot(3,2,3)
        temp = fft(mean(imf, 1));
        plot([2: width] ./ width, abs(temp(2:end)))

        ax = subplot(3,2,5);
        bar([2: width] ./ width, c(2:end))
        xlim(ax, [0, 1])
    end

    records = peak_detection(c, W, T);

    [B, I] = sort(records, 'descend');
    I = I ./ width;
    B = B ./ height;

    counting_thres = 0.15;
    if B(1) >= counting_thres
        if B(2) >= counting_thres
            f1 = min(I(1), I(2));
            f2 = max(I(1), I(2));
            rotate_estimate = [acosd(1 - f1), asind(f2)];
            
            if abs(rotate_estimate(1) - rotate_estimate(2)) > 3
                disp('estimated angle > 30')
                rotate_estimate(2) = asind(1 - f2);
            end
        else
            % may result from angle too small
            % which makes peak f1 too small to be found
            f2 = I(1);
            rotate_estimate = [nan, asind(f2)];
        end    
        output = [rotate_estimate; 1/I(1), 1-1/I(1)];
%         output(output > 45) = 0;
    else
        output = zeros(2);
    end
    
end

