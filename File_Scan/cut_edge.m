%自动裁边工具.
%1.缩小图像
%2.检测纸张边缘.
%3.沿边缘作垂直线

%1.缩小图像, 二值化
I=uigetphoto;
if ndims(I)>1, I=rgb2gray(I); end;
I=imresize(I,2300/size(I,1));
figure; imshow(I);
BW=im2bw(I,0.35);

%2.寻找边界
[y,x]=ind2sub(size(I),findN(BW,10));
temp = vision.BoundaryTracer('MaximumPixelCount',10000,.....
    'TraceDirection','Counterclockwise');
bound = fliplr(step(temp, BW, [x y])); %矩阵sub
figure; imshow(BW);hold on; Plot(fliplr(bound),'LineWidth',5);%画图

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

Scatter(fliplr(bound([ind1 ind2 ind3 ind4],:)));

%4.水平切成许多四边形
Plot(fliplr(bound([ind1 ind4],:)));
Plot(fliplr(bound([ind2 ind3],:)));
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
for ii=1:N+1
    Plot(fliplr(bound([ind12(ii) ind34(ii)],:)));
end

%获得图片的尺寸(单位像素)
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
for ii=1:N
     sub4=bound([ind12(ii:ii+1) ind34([ii+1,ii]) ],:);
     I1(H*(ii-1)+1:H*ii, :)=imrectangle_mex(I,sub4,size1);
end

figure; imshow(I1)

