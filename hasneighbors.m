function result = hasneighbors(matrix, x, y)
mv = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];
smv = 8;

[h, w] = size(matrix);

result = 0;
for i = 1 : smv
    nx = x + mv(i, 1);
    ny = y + mv(i, 2);
    if nx > 0 && ny > 0 && nx <= h && ny <= w && matrix(nx, ny) ~= 0
        result = 1;
        break;
    end
end

end
