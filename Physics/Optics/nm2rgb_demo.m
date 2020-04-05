% nm2rgb_demo

N = 3000;
lambda = linspace(380, 750, N);
rgb = nm2rgb(lambda);
rgb1 = uint8(zeros(1, N, 3));
rgb1(1,:,:) = rgb;
rgb2 = repmat(rgb1, round(N/6), 1);
figure; imshow(rgb2);
