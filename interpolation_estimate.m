function [output, I, B] = interpolation_estimate(imr, delta, W, T)
    filter = fspecial('laplacian');
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

    rowf_sum = rowf_sum ./ height;
    subplot(3,1,1)
    plot([2: width] ./ width, abs(rowf_sum(2:end)))

    subplot(3,1,2)
    temp = fft(mean(imf, 1));
    plot([2: width] ./ width, abs(temp(2:end)))

    ax = subplot(3,1,3);
    bar([2: width] ./ width, c(2:end))
    xlim(ax, [0, 1])

    records = peak_detection(c, W, T);

    [B, I] = sort(records, 'descend');
    I = I ./ width;

    a = I(1);
    b = I(2);
    output = [acosd(1 - a), asind(b), 1/a];
end

