function result = hasSimilar(freqa, freqb, x, y)

mv = [-1, -1; -1, 0; -1, 1; 0, -1; 0, 1; 1, -1; 1, 0; 1, 1];
smv = 8;

result = 0;

[h, w] = size(freqa);

mya = freqa(x, y);
myb = freqb(x, y);
for i = 1 : smv
    nx = x + mv(i, 1);
    ny = y + mv(i, 2);
    if nx > 0 && nx <= h && ny > 0 && ny <= w
        if mya == freqa(nx, ny) || ...
            mya == freqb(nx, ny) || ...
            myb == freqa(nx, ny) || ...
            myb == freqb(nx, ny)
            result = 1;
            break;
        end
    end
end
