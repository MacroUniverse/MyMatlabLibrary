%手动选图
%图片文件夹可以不在路径下


[name, pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
if ~iscell(name)
    name={name};
end
cd0=cd;
cd(pathname);

N=numel(name);
I=cell(N,1);
for ii=1:N
    I{ii}=imread(name{ii});
end

cd(cd0);