%自动矫正, 裁剪扫描后的原始图片
%ColorMode='gray'或者'rgb'(默认与原图一致)
%本身是灰度图是, 只能是'gray'
%scale是缩小尺寸, 可以是比例也可以是垂直像素数量(自动判断)
%只要输入draw~=0, 就画图, 不输入或者draw=0就不画图

function scanAdjust(ColorMode,scale,draw)

%判断画图
if ~exist('draw','var') || draw==0
    draw=0;
else
    draw=1;
end

%判断压缩图像
if ~exist('scale','var')
    scale=0;
end

if ~exist('ColorMode','var')
    ColorMode=[];
end

path0=cd;

%选择要处理的图片
[name, path1]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
if isa(name,'char')
    name={name}; 
end

%选择要储存的位置
path2=uigetdir; 

%处理图像

for ii=1:numel(name)
    disp(['正在处理第' num2str(ii) '张图片:' name{ii}]);
    cd(path1);
    I=imread(name{ii});    
    I1=f(I,ColorMode,scale,draw);
    cd(path2);
    imwrite(I1,name{ii},name{ii}(end-2:end));
end

cd(path0);
end

function I1=f(I,ColorMode,scale,draw)

%压缩图片
if scale~=0
    if scale>20
        scale=scale/size(I,1);
    end
    I=imresize(I,scale);
end

if draw==1, figure; imshow(I); end

%判断色彩模式
if isempty(ColorMode)
    if ndims(I)>1
        ColorMode='rgb';
    else
        ColorMode='gray';
    end
end

%色彩转换, 另生成二值化图像
if ColorMode(1)=='g' && ndims(I)==3
    I=rgb2gray(I);
elseif ColorMode(1)=='r' && ismatrix(I)
    ColorMode='gray';
end
BW=im2bw(I,0.35);

%2.寻找边界
[y,x]=ind2sub(size(I),findN(BW,10));
temp = vision.BoundaryTracer('MaximumPixelCount',10000,.....
    'TraceDirection','Counterclockwise');
bound = fliplr(step(temp, BW, [x y])); %矩阵sub
if draw==1
    figure; 
    imshow(BW);hold on; Plot(fliplr(bound),'LineWidth',3);%画图
end

%3.寻找bound中四个角的索引
temp=bound(:,1)+bound(:,2);
[~,ind3]=max(temp);
[~,ind1]=min(temp);
temp=bound(:,2)-bound(:,1);
[~,ind4]=max(temp);
[~,ind2]=min(temp);

%重新命名bound的序号, 使ind1=1;
bound=[bound(ind1:end,:); bound(1:ind1-1,:)];
diff=ind1-1; temp=size(bound,1);
ind1=ind1-diff; if ind1<1, ind1=ind1+temp; end
ind2=ind2-diff; if ind2<1, ind2=ind2+temp; end
ind3=ind3-diff; if ind3<1, ind3=ind3+temp; end
ind4=ind4-diff; if ind4<1, ind4=ind4+temp; end
if draw==1
    Scatter(fliplr(bound([ind1 ind2 ind3 ind4],:)));
end

%4.水平切成许多四边形
% Plot(fliplr(bound([ind1 ind4],:)));
% Plot(fliplr(bound([ind2 ind3],:)));
N=20;
ind12=round(linspace(ind1,ind2,N+1));

%垂直选线的方法(效果不尽人意, 另一边的切点分布不均匀
% indC=zeros(N+1,1);
% for ii=2:N
%      indC(ii)=cut_edge_devide2(bound, ind12(ii-1), ind12(ii), ind3, ind4);
%     Plot(fliplr(bound([ind12(ii) indC(ii)],:)));
% end

%两边等分的办法(测试结果非常完美, 每条线和字都是对齐的)
ind34=round(linspace(ind4,ind3,N+1));
% for ii=1:N+1
%     Plot(fliplr(bound([ind12(ii) ind34(ii)],:)));
% end

%5.获得矫正图片的尺寸(单位像素)
W=zeros(N+1,1);
for ii=1:N+1
    W(ii)=vmag(bound(ind12(ii),:)-bound(ind34(ii),:));
end
W=round(mean(W));

H1=0; H2=0;
for ii=2:N+1
    H1=H1+vmag(bound(ind12(ii),:)-bound(ind12(ii-1),:));
    H2=H2+vmag(bound(ind34(ii),:)-bound(ind34(ii-1),:));
end
H=round((H1+H2)/2/N);
I1=cast(zeros(H*N, W, size(I,3)),class(I));
size1=[H,W];

%分片矫正, 拼接校正后图像
for ii=1:N
     sub4=bound([ind12(ii:ii+1) ind34([ii+1,ii]) ],:);
     if ColorMode(1)=='r'
         I1(H*(ii-1)+1:H*ii, :, :)=.....
               imrectangleRGB_mex(I(:,:,1), I(:,:,2), I(:,:,3), sub4,size1);
     elseif ColorMode(1)=='g'
         I1(H*(ii-1)+1:H*ii, :)=imrectangle_mex(I,sub4,size1);
     end
end

if draw==1
    figure; imshow(I1);
end

end

