function test_resizing(imr, pausing)
    delta = 5;
    W = 2;
    T = 2;
    show = 1;
    figure('pos',[10 10 800 400])
    
    factors = 0.1:0.1:3.7;
    record = zeros(5, size(angles, 2));
    for factor = factors
        imr_resize = imresize(imr, factor, 'bilinear');
        [rotate_estimate, resize_estimate,  I, B] = interpolation_estimate(imr_resize, delta, W, T, show);
        fprintf('Resizing factor by %.2f\n', factor)
        fprintf('Eestimated factor: %.3f, %.3f, %.3f\n', resize_estimate)
        fprintf('Estimated angle: %.3f, %.3f\n\n', rotate_estimate)
        record(1:2, angle) = rotate_estimate;
        record(3:5, angle) = resize_estimate;
        pause(pausing)
    end
end

