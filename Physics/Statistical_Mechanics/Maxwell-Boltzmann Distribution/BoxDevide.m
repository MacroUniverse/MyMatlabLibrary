%把长方体空间划分成许多格子, 把空间点P划分到这些格子里面.
%size(P)=[N,3]
%position就是[Xmin,Xmax,Ymin,Ymax,Zmin,Zmax]
%N就是[Nx,Ny,Nz].
%Box是行矢量

%格子的划分为 x1<=x<x

function [Box,Np]=BoxDevide(P,position,N)

dx=abs(position(2)-position(1))/N(1);
dy=abs(position(4)-position(3))/N(2);
dz=abs(position(6)-position(5))/N(3);

x=P(:,1);y=P(:,2);z=P(:,3);

xii=floor(x/dx)+1;
yii=floor(y/dy)+1;
zii=floor(z/dz)+1;

Box=cell(N(1),N(2),N(3));
Np=zeros(N(1),N(2),N(3));
for ii=1:size(P,1)
    Box{xii(ii),yii(ii),zii(ii)}=[Box{xii(ii),yii(ii),zii(ii)} ii];
    Np(xii(ii),yii(ii),zii(ii))=Np(xii(ii),yii(ii),zii(ii))+1;
end

end