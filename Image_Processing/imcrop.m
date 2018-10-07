% crop all images
function imcrop()
[filename,path] = uigetfile('*.*', 'multiselect', 'on');
olddir = cd;
cd(path);
I = imread(filename{1}); imshow(I);
imin = input('i_min :'); imax = input('i_max :');
jmin = input('j_min :'); jmax = input('j_max :');
for ii = 1:numel(filename)
    I = imread(filename{ii});
    I = I(imin:imax,jmin:jmax);
    imwrite(I,filename{ii});
end
cd(olddir);
end