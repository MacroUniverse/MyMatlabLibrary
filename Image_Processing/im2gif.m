function im2gif()
[filename,path] = uigetfile('*.*', 'multiselect', 'on');
cd(path);
I = imread(filename{1});
imwrite(I, 'infinity.gif', 'gif', 'Loopcount', inf, 'DelayTime', 0.08);
for ii = 2:numel(filename)
I = imread(filename{ii});
imwrite(I, 'infinity.gif', 'gif', 'WriteMode', ....
        'append', 'DelayTime', 0.08);
end
end