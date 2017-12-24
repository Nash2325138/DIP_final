function record = test_rotation(imr, pausing)
    delta = 5;
    W = 2;
    T = 2;
    show = 1;
    figure('pos',[10 10 800 400])
    angles = 1:45;
    record = zeros(5, size(angles, 2));
    for angle = angles
        imr_rotate = imRotateCrop(imr, angle, 'bilinear'); 
        [rotate_estimate, resize_estimate,  I, B] = interpolation_estimate(imr_rotate, delta, W, T, show);
        fprintf('Rotating by %d\n', angle)
        fprintf('Eestimated factor: %.3f, %.3f, %.3f\n', resize_estimate)
        fprintf('Estimated angle: %.3f, %.3f\n\n', rotate_estimate)
        record(1:2, angle) = rotate_estimate;
        record(3:5, angle) = resize_estimate;
        pause(pausing)
    end
end

