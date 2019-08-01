% concatinate images

for i = 8:8:2400
    I1 = imread(['dwv' num2str(i) '.png']);
    I2 = imread(['nwv' num2str(i) '.png']);
    I3 = imread(['owv' num2str(i) '.png']);
    I = imresize([I1;I2;I3], 0.6);
    imwrite(I, ['wv' num2str(i) '.png']);
end
