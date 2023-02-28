%批量选取图片, 转化为二值图, 在源目录下保存为tif, 分辨率为600dpi

%图片信息中,分辨率(单位长度的像素)很重要! 如果分辨率太小,pdf尺寸过大,会无法进行文本识别等等操作. 非常麻烦!!!

%关于二值图的格式:
%如果不压缩,png的体积最小(单张实验:263kb)
%如果压缩,tif用fax4压缩法体积最小(单张实验:110kb)

function BinaryTif
dpi=600; %设置分辨率

[name, pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
cd(pathname);
N=numel(name);
for ii=1:N
    I=imread(name{ii});
    I=im2bw(I,0.6); %0.7是唯彩扫描仪的最佳实验值 (数值越低颜色越浅)
    %temp=dpi*39.37; %因为png只能用"每米的像素"作分辨率单位, 所以要乘以每米的英寸数 100/2.54=39.37
    %imwrite(I,[name{ii}(1:end-3) 'png'], 'resolutionunit','meter','xresolution',temp, 'yresolution', temp); %会读函数文档有多重要....
    imwrite(I,[name{ii}(1:end-3) 'tif'], 'resolution',dpi,'compression','fax4');
end
end

