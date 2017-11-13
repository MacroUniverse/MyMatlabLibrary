%麦克斯韦-波尔兹曼分布

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%参数设置
N=1000; %总粒子数
m=1e-3; %粒子质量
R=1e-3; %粒子半径
%容器规格
Size=[1,1,1];%[x长度, y长度, z长度].0<x<x长度, y...,z....
T=300; %温度设置

Time=10; %模拟总时间

kb=1.380650324;%波尔兹曼常量

%每个粒子的位置矢量
for ii=3:-1:1
    P(:,ii)=rand(N,1)*Size(ii);
end
%每个粒子的速度矢量
V=rand(N,3);
V=vunit(V)*sqrt(3*kb*T/m);  %每个粒子都要有平均动能
v=vmag(V); %速度绝对值

%判断应该分多少区间
%最小值(一个格子至少能装一个粒子, 保证只有相邻的格子能发生碰撞)
Nx=ceil(Size(1)/(2.01*R));
Ny=ceil(Size(2)/(2.01*R));
Nz=ceil(Size(3)/(2.01*R));

if N>Nx*Ny*Nz
    temp=(N/Nx/Ny/Nz)^(1/3);
    Nx=ceil(Nx*temp); Ny=ceil(Ny*temp); Nz=ceil(Nz*temp);
end

%把容器分成若干区间

for ii=1
    %划分格子,分类
    [Box,Np]=BoxDevide(P,[0 Size(1) 0 Size(2) 0 Size(3) ],[Nx,Ny,Nz]);
    %找到距离小于Rcriti的序号较小粒子.在list中做标记
    Rcriti=2*R;
    CheckDistance;
    %在list中找到将要碰撞的序号较小的粒子, 在Tremain中标记碰撞所需的时间.
    %并且找到下一次碰撞的时间Tmin
    collision;
    Time=Time+Tmin;
    %计算Tm时间以后的所有粒子的状态P,V,v
    PVrenew;
end





    
    