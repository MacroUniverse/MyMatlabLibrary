% Data Extractor for Plot
% x and y are both scaled to the range [0,1]
function [x,y] = plot2data
disp('请选择图片')
[filename,path]=uigetfile('*.*');
cd(path);
I = imread(filename);
figure; imshow(I); hold on;
disp('放大图片以选取坐标原点 (7s)');
pause(7);
disp('选取坐标原点')
P0 = ginput(1); scatter(P0(1),P0(2));

disp('放大图片以选取 x 轴最大值 (7s)');
pause(7);
disp('选取 x 最大值')
Px = ginput(1); scatter(Px(1),Px(2));

disp('放大图片以选取 y 轴最大值 (7sec)');
pause(7);
disp('选取 y 最大值')
Py = ginput(1); scatter(Py(1),Py(2));
P = [];
while 1
    disp('放大图片以选取图中一组数据点 (7sec)');
    pause(7);
    disp('选取图中一组数据点')
    temp = ginput;
    if ~isempty(temp)
        scatter(temp(:,1),temp(:,2));
        P = [P; temp];
        if nargout == 0
            save plot2data.mat P
        end
    end
    temp = input('继续:回车; 结束:1');
    if ~isempty(temp)
        break;
    end
end
x = (P(:,1)-P0(1))/(Px(1)-P0(1));
y = (P(:,2)-P0(2))/(Py(2)-P0(2));
save plot2data.mat x y
end
