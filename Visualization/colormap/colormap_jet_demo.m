% colormap_jet_demo
N = 1000;
val = linspace(0, 1, N);
rgb = colormap_jet(val);
% rgb = colormap_jet2(val);
rgb1 = uint8(zeros(1, N, 3));
rgb1(1,:,:) = rgb;
rgb2 = repmat(rgb1, round(N/6), 1);
figure; imshow(rgb2);
