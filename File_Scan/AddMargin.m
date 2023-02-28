%先把相片转换成灰度图然后四周加边

Margin=[120 120 120 120]; %上下左右
[name, pathname]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
cd(pathname);
if ~iscell(name)
    name={name};
end

N=numel(name);

for ii=1:N
    disp(ii);
    [X,map]=imread(name{ii}); %非常奇葩, 如果不用ind图像输出, 图像就会变质...
    if isempty(map) %结果就变得好复杂...
        II=imread(name{ii});
        if ndims(II)==3;
            II=rgb2gray(II);
        end
    else
        II=ind2gray(X,map);
    end %弄个灰度图真不容易
    ImageSize=size(II);
    temp=255*ones(ImageSize(1)+Margin(1)+Margin(2), ImageSize(2)+Margin(3)+Margin(4));
    temp=uint8(temp);
    temp(Margin(1)+1:Margin(1)+ImageSize(1),Margin(3)+1:Margin(3)+ImageSize(2))=II;
    II=temp;
    temp=[name{ii}(1:end-3) 'jpg'];
    delete(name{ii});
    imwrite(II,temp,'jpg');
end

