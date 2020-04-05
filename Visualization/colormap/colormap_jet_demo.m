% colormap_jet_demo
N = 1000;
val = linspace(0, 1, N);

% rgb = colormap_jet(val);
% rgb = colormap_jet2(val);
rgb = colormap_spec(val);

rgb1 = uint8(255*rgb);
rgb2 = uint8(zeros(1, N, 3));
rgb2(1,:,:) = rgb1;
rgb3 = repmat(rgb2, round(N/6), 1);
figure; imshow(rgb3);
