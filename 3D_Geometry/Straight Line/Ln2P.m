%空间中多条直线近似交点的加权最小二乘法算法
%这里的Lerr是一个点的所有直线
%size(Lerr2)=[n,9]

function [P,Hs]=Ln2P(Lerr2)

n=size(Lerr2,1);%射线的条数
%先求出一个粗略交点, 计算误差, 用误差决定权重
[~,ind]=sort(Lerr2(:,7),'descend');
L1=Lerr2(ind(1), 1:6);
L2=Lerr2(ind(2), 1:6);
P0=L22P(L1,L2);
S=vmag(repmat(P0,n,1)-Lerr2(:,1:3));
angerr=Lerr2(:,8);
err=S.*angerr;%Perr是没必要的,因为Pmn2S2函数中, angerr已经包含了Perr所产生的误差
weight=1.1-err./max(err);%目前的权重公式, 可修改

px=Lerr2(:,1); py=Lerr2(:,2); pz=Lerr2(:,3);
ex=Lerr2(:,4); ey=Lerr2(:,5); ez=Lerr2(:,6);

exey=weight.*ex.*ey; eyez=weight.*ey.*ez; ezex=weight.*ez.*ex;
exex=weight.*ex.*ex; eyey=weight.*ey.*ey; ezez=weight.*ez.*ez;

Sexey=sum(exey); Seyez=sum(eyez); Sezex=sum(ezex);
Sexex=sum(exex); Seyey=sum(eyey); Sezez=sum(ezez);

Sexeypx=sum(exey.*px); Sexeypy=sum(exey.*py);
Seyezpy=sum(eyez.*py); Seyezpz=sum(eyez.*pz);
Sezexpz=sum(ezex.*pz); Sezexpx=sum(ezex.*px);
Cx=sum((eyey+ezez).*px);Cy=sum((ezez+exex).*py); Cz=sum((exex+eyey).*pz);

M=[  Seyey+Sezez              -Sexey               -Sezex 
                  -Sexey    Sezez+Sexex               -Seyez
                 -Sezex               -Seyez     Sexex+Seyey ];
  
C=[ Cx-Sexeypy-Sezexpz
      Cy-Seyezpz-Sexeypx
      Cz-Sezexpx-Seyezpy];


P=(M\C)';

Hs=LP2H(Lerr2(:,1:6),repmat(P,n,1));

end