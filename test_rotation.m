function test_rotation(imr)
    delta = 5;
    W = 2;
    T = 2;
    show = 1;
    figure('pos',[10 10 800 400])
    pause(3)
    for angle = 1:45
        imr_rotate = imRotateCrop(imr, angle, 'bilinear'); 
        [output, I, B] = interpolation_estimate(imr_rotate, delta, W, T, show);
        fprintf('Rotating by %d\n', angle)
        fprintf('Estimated angle: %.3f, %.3f\n\n', output(1, 1:end))
        pause(0.5)
    end

end

