%调取窗口选择需要导入的相片
%输出的I是元胞数组
%name是元胞数组
%pathname是不知道
function [I,name,pathname]=uigetphoto
[name, pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
cd0=cd;
cd(pathname);
if isa(name, 'cell')==0
    I=imread(name);
else
    I=cell(numel(name),1);
    for ii=1:numel(name)
        I{ii}=imread(name{ii});
    end
end

cd(cd0);
end