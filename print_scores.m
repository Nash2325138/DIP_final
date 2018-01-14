function print_scores(true_mark, pred_mark)
    [h, w] = size(true_mark);
%     [TP, TN, FP, FN] = [0, 0, 0, 0];
    TP = 0;
    TN = 0;
    FP = 0;
    FN = 0;
    for i=1:h
        for j=1:w
            if true_mark(i, j) == 1 && pred_mark(i, j) == 1
                TP = TP + 1;
            elseif true_mark(i, j) == 0 && pred_mark(i, j) == 1
                FP = FP + 1;
            elseif true_mark(i, j) == 1 && pred_mark(i, j) == 0
                FN = FN + 1;
            elseif true_mark(i, j) == 0 && pred_mark(i, j) == 0
                TN = TN + 1;
            end
        end
    end
    all = sum([TP, TN, FP, FN]);
    fprintf('Accuracy: %.3f\n', (TP+TN)/all)
    fprintf('Recall: %.3f\n', (TP)/(TP+FN))
    fprintf('Precision: %.3f\n', (TP)/(TP+FP))
end

