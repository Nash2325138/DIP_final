function record = test_rotation(imr, pausing)
    delta = 5;
    W = 2;
    T = 2;
    show = 3;
    figure('pos',[10 10 1200 600])
    angles = 0:45;
    record = zeros(5, size(angles, 2));
    for i = 1:size(angles, 2)
        angle = angles(i);
        imr_rotate = imRotateCrop(imr, angle, 'bilinear');
        [rotate_estimate, resize_estimate,  I, B] = interpolation_estimate(imr_rotate, delta, W, T, show);
        
%         axes('Units','Normal');
%         h = title(sprintf('Rotated by %d degree (bilinear)', angle), 'FontSize', 20);
%         set(gca,'visible','off')
%         set(h,'visible','on')
        if show == 3
            subplot(4,2,8);
            h = title(sprintf('Rotated by %d degree (bilinear)', angle), 'FontSize', 25);
            set(h,'visible','on')
        end
        saveas(gcf, sprintf('./demo/animation/2/rotate/%03d.png', i-1))

        fprintf('Rotating by %d\n', angle)
        fprintf('Eestimated factor: %.3f, %.3f, %.3f\n', resize_estimate)
        fprintf('Estimated angle: %.3f, %.3f\n\n', rotate_estimate)
        record(1:2, i) = rotate_estimate;
        record(3:5, i) = resize_estimate;
        pause(pausing)
    end
end

