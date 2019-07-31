function im2gif()
% === params =====
fname = 'wv3bc.gif';
Ncolor = 32;
dt = 0.1;
% ================
[filename,path] = uigetfile('*.*', 'multiselect', 'on');
cd(path);
I = imread(filename{1});
[X,cmap] = rgb2ind(I,Ncolor);
imwrite(X, cmap, fname, 'gif', 'Loopcount', inf, 'DelayTime', dt);
for ii = 2:numel(filename)
I = imread(filename{ii});
[X,cmap] = rgb2ind(I,Ncolor);
imwrite(X, cmap, fname, 'gif', 'WriteMode', ....
        'append', 'DelayTime', dt);
end
end
