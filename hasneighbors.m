function result = hasneighbors(matrix, ftopa, ftopb, x, y)

% mv = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];
% smv = 8;
mv = [-1, 0; 1, 0; 0, -1; 0, 1];
smv = 4;

[h, w] = size(matrix);

result = 0;
for i = 1 : smv
    nx = x + mv(i, 1);
    ny = y + mv(i, 2);
    if nx > 0 && ny > 0 && nx <= h && ny <= w && matrix(nx, ny) ~= 0
        if ftopa(nx, ny) == ftopa(x, y) || ...
            ftopa(nx, ny) == ftopb(x, y) || ...
            ftopb(nx, ny) == ftopa(x, y) || ...
            ftopb(nx, ny) == ftopb(x, y)
            result = 1;
            break;
        end
    end
end

end
