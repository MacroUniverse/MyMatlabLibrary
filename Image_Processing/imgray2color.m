function I1 = imgray2color(I, color)
I = double(I) / 255;
N1 = size(I,1); N2 = size(I,2);
I1 = uint8(zeros(N1,N2,3));
for j = 1:N2
    for i = 1:N1
        I1(i, j, :) = color * (1-I(i, j)) + [255 255 255] * I(i, j);
    end
end
end
