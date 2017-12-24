function record = test_resizing(imr, pausing)
    delta = 5;
    W = 2;
    T = 2;
    show = 2;
    figure('pos',[10 10 1200 400])
    
    factors = 0.1:0.1:3.7;
    record = zeros(5, size(factors, 2));
    for i = 1:size(factors, 2)
        factor = factors(i);
        imr_resize = imresize(imr, factor, 'bilinear');
        [rotate_estimate, resize_estimate, I, B] = interpolation_estimate(imr_resize, delta, W, T, show);
        
        axes('Units','Normal');
        h = title(sprintf('Resize by %.1f (Bilinear)', factor), 'FontSize', 20);
        set(gca,'visible','off')
        set(h,'visible','on')
        saveas(gcf, sprintf('./demo/animation/1/resize/%03d.png', i-1))

        fprintf('Resizing factor by %.2f\n', factor)
        fprintf('Eestimated factor: %.3f, %.3f, %.3f\n', resize_estimate)
        fprintf('Estimated angle: %.3f, %.3f\n\n', rotate_estimate)
        record(1:2, i) = rotate_estimate;
        record(3:5, i) = resize_estimate;
        pause(pausing)
    end
end

