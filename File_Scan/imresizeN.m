%批量修改分辨率(临近插值法)
%必须一张张读取,处理,储存. 否则内存肯定不够.
%保持原来的图像格式不变.

path0=cd;
[name, path1]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
if isa(name,'char')
    name={name}; 
end
path2=uigetdir; 

for ii=1:numel(name)
    cd(path1);
    I1=imresize(imread(name{ii}),2000/2929);
    I1=im2bw(I1);
    cd(path2);
    %imwrite(I1,name{ii},name{ii}(end-2:end));
    name{ii}(end-2:end)='bmp';
    imwrite(I1,name{ii},'bmp');
end

cd(path0);