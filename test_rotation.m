function test_rotation(imr)
    delta = 5;
    W = 2;
    T = 2;
    show = 1;
    figure('pos',[10 10 800 400])
    for angle = 1:45
        imr_rotate = imRotateCrop(imr, angle, 'bilinear'); 
        [rotate_estimate, resize_estimate,  I, B] = interpolation_estimate(imr_rotate, delta, W, T, show);
        fprintf('Rotating by %d\n', angle)
        fprintf('Eestimated factor: %.3f, %.3f, %.3f\n', resize_estimate)
        fprintf('Estimated angle: %.3f, %.3f\n\n', rotate_estimate)
        pause(0.5)
    end
end

