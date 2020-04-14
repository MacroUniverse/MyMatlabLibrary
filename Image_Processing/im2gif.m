function im2gif()
% === params =====
fname = 'animation.gif';
Ncolor = 64; % gif support a maximum of 256 (index must be uint8 type)
dt = 0.1;
% ================
[filename,path] = uigetfile('*.*', 'multiselect', 'on');
cd(path);
I = imread(filename{1});
[X,cmap] = rgb2ind(I,Ncolor,'nodither');
imwrite(X, cmap, fname, 'gif', 'Loopcount', inf, 'DelayTime', dt);
figure;
for ii = 2:numel(filename)
    if strcmp(filename{ii}, fname)
        continue;
    end
    I = imread(filename{ii});
    [X,cmap] = rgb2ind(I,Ncolor,'nodither');
    imshow(X, cmap); drawnow;
    imwrite(X, cmap, fname, 'gif', 'WriteMode', ....
            'append', 'DelayTime', dt);
end
end
