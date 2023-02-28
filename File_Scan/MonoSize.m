%横向扫描书截图程序
%使每幅图的大小都一样, 页码的位置都一样.
%准备好元胞数组I.

[name, pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
cd(pathname);
if ~iscell(name)
    name={name};
end

Size=[3476; 4631];
Margin=[50; 50];
Scale=2048/Size(2);

close all; 
N=numel(name);

for ii=1:N
    II=rgb2gray(imread(name{ii}));       %变成灰度图
    figure(1); imshow(II); %显示灰度图
    p=round(ginput(1));
    if p(1)>0.5*Size(1) %如果页码在右上角
        right=p(1)+Margin(1);
        left=right-Size(1)+1;
        top=p(2)-Margin(2);
        bottom=top+Size(2)-1;
        ImageSize=size(II);
        %上下剪切
        if bottom>ImageSize(1)
            II=II(top:ImageSize,:);
            II=[II; 255*ones(bottom-ImageSize,ImageSize(2))];
        else
            II=II(top:bottom,:);
        end
        %左右剪切
        if left<1
            II=II(:,1:right);
            II=[255*ones(Size(2),1-left) II];
        else
            II=II(:,left:right);
        end
    else %如果页码在左上角
        left=p(1)-Margin(1);
        right=left+Size(1)-1;
        top=p(2)-Margin(2);
        bottom=top+Size(2)-1;
        ImageSize=size(II);
        %上下剪切
        if bottom>ImageSize(1)
            II=II(top:ImageSize,:);
            II=[II; 255*ones(bottom-ImageSize,ImageSize(2))];
        else
            II=II(top:bottom,:);
        end
        %左右剪切
        if right>ImageSize(2)
            II=II(:,left:end);
            II=[II 255*ones(Size(2),right-ImageSize(2))];
        else
            II=II(:,left:right);
        end
    end
    %调整大小
    II=imresize(II,Scale);
    figure(2); imshow(II);
    temp=[name{ii}(1:end-3) 'bmp'];
    imwrite(II,temp,'bmp');
end