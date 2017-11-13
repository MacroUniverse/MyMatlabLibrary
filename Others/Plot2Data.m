% Data Extractor for Plot
% x and y are both scaled to the range [0,1]
function [x,y]=Plot2Data
if nargout~=2
    error('Must use 2 output variables, or data will be lost');
end
disp('select image file')
[filename,path]=uigetfile('*.*');
cd(path);
I = imread(filename);
figure; imshow(I); hold on;
disp('zoom in to select origin (7second)');
pause(7);
disp('select origin')
P0 = ginput(1); scatter(P0(1),P0(2));

disp('zoom in to select x maximum (7sec)');
pause(7);
disp('select x maximum')
Px = ginput(1); scatter(Px(1),Px(2));

disp('zoom in to select y maximum (7sec)');
pause(7);
disp('select y maximum')
Py = ginput(1); scatter(Py(1),Py(2));
P = [];
while 1
    disp('zoom in to select points (7sec)');
    pause(7);
    disp('select points')
    temp = ginput;
    if ~isempty(temp)
        scatter(temp(:,1),temp(:,2));
        P = [P; temp];
        save Plot2Data.mat
    end
    temp = input('continue:[],end:1');
    if ~isempty(temp)
        break;
    end
end

x = (P(:,1)-P0(1))/(Px(1)-P0(1));
y = (P(:,2)-P0(2))/(Py(2)-P0(2));
end