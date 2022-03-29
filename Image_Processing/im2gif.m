function im2gif()
% === 参数 =====
fname = 'animation.gif'; % 文件名
Ncolor = 64; % 颜色数（最大 256）
dt = 0.05; % 间隔时间（秒）
dt_beg = 0.5; % 第一帧时间（秒）
dt_end = 0.5; % 最后一帧时间（秒）
% ================
[filename,path] = uigetfile('*.*', 'multiselect', 'on');
cd(path);
I = imread(filename{1});
[X,cmap] = rgb2ind(I,Ncolor,'nodither');
imwrite(X, cmap, fname, 'gif', 'Loopcount', inf, 'DelayTime', dt_beg);
figure;
N = numel(filename);
for ii = 2:N
    if strcmp(filename{ii}, fname)
        continue;
    end
    I = imread(filename{ii});
    [X,cmap] = rgb2ind(I,Ncolor,'nodither');
    imshow(X, cmap); drawnow;
    if ii == N
        dt = dt_end;
    end
    imwrite(X, cmap, fname, 'gif', 'WriteMode', ....
            'append', 'DelayTime', dt);
end
end
