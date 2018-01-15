# DIP_final

## Report

For detailed description of what we've done, please refer to our [report](https://github.com/Nash2325138/DIP_final/blob/master/report/Report.pdf).

## To run

If you want to get the results in the report, please run final.m, where there are two tests for Algorithm 1 and 2.

It's preferred to run one of them and comment the other at one time.

### Algorithm 1 test
It will give you the same results of demo videos (estimation of rotation, resizing factor)

### Algorithm 2 test
It will perform a splicing image detection with B=128, L=32, T_ratio=0.2, 0.24, or 0.28.
This test takes around 177 seconds in our computer. If you don't want to wait, just run:
```
load demo/final_test2.mat
for i = 1:size(Ts_ratio, 2)
    figure
    paras_str = sprintf('B=%d, L=%d, T ratio=%.2f', B, L, Ts_ratio(i));
    rect_suspicious(spliced, squeeze(suspiciousGraphs(i, :, :)), B, L);
    title(paras_str)
    fprintf('\nThe scores of %s:\n', paras_str);
    print_scores(should_be_marked, squeeze(suspiciousGraphs(i,:,:)))
end
```
