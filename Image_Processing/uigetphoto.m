%通过windows文件窗口选择图片, 并把选中的图片读入元胞数组I

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