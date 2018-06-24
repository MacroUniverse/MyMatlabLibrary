function [Pa,Pb,Pc,Pd,Pe,Pf,Pg,Ph,flat5,flat6]=body60(RorHorL,draw)

%生成平面上的五边形
R=1/2/sin(36/180*pi);
Pa=zeros(5,3); 
temp=linspace(pi/2,18/180*pi+2*pi,5);
Pa(:,1)=R*cos(temp)';
Pa(:,2)=R*sin(temp)';

%计算出第二层五个点
Pb(5,:)=P32P(Pa([1 5 4],:));
Pb(1,:)=P32P(Pa([2 1 5],:));
Pb(2,:)=P32P(Pa([3 2 1],:));
Pb(3,:)=P32P(Pa([4 3 2],:));
Pb(4,:)=P32P(Pa([5 4 3],:));

%仅用补全多边形的方法,就可以生成剩下所有的点

[Pc(9,:),Pc(10,:)]=hexagon([Pa([1 5],:); Pb(5,:)]);%第1层6边形
[Pc(1,:),Pc(2,:)]=hexagon([Pa([2 1],:); Pb(1,:)]);
[Pc(3,:),Pc(4,:)]=hexagon([Pa([3 2],:); Pb(2,:)]);
[Pc(5,:),Pc(6,:)]=hexagon([Pa([4 3],:); Pb(3,:)]);
[Pc(7,:),Pc(8,:)]=hexagon([Pa([5 4],:); Pb(4,:)]);

[Pd(9,:),Pd(10,:)]=pentagon([Pc(1,:); Pb(1,:); Pc(10,:)]);%第2层5边形
[Pd(1,:),Pd(2,:)]=pentagon([Pc(3,:); Pb(2,:); Pc(2,:)]);
[Pd(3,:),Pd(4,:)]=pentagon([Pc(5,:); Pb(3,:); Pc(4,:)]);
[Pd(5,:),Pd(6,:)]=pentagon([Pc(7,:); Pb(4,:); Pc(6,:)]);
[Pd(7,:),Pd(8,:)]=pentagon([Pc(9,:); Pb(5,:); Pc(8,:)]);
%-----------------------------------------------------------------------------------球心
[Pe(9,:),Pe(10,:)]=hexagon([Pc([10 9],:);Pd(8,:)]);%第2层6边形
[Pe(1,:),Pe(2,:)]=hexagon([Pc([2 1],:);Pd(10,:)]);
[Pe(3,:),Pe(4,:)]=hexagon([Pc([4 3],:);Pd(2,:)]);
[Pe(5,:),Pe(6,:)]=hexagon([Pc([6 5],:);Pd(4,:)]);
[Pe(7,:),Pe(8,:)]=hexagon([Pc([8 7],:);Pd(6,:)]);

[Pf(10,:),Pf(1,:)]=hexagon([Pd([10 9],:);Pe(10,:)]);%第2层6边形
[Pf(2,:),Pf(3,:)]=hexagon([Pd([2 1],:);Pe(2,:)]);
[Pf(4,:),Pf(5,:)]=hexagon([Pd([4 3],:);Pe(4,:)]);
[Pf(6,:),Pf(7,:)]=hexagon([Pd([6 5],:);Pe(6,:)]);
[Pf(8,:),Pf(9,:)]=hexagon([Pd([8 7],:);Pe(8,:)]);

Pg(5,:)=pentagon([Pe(10,:);Pe(9,:);Pf(9,:)]);%第3层5边形
Pg(1,:)=pentagon([Pe([2 1],:);Pf(1,:)]);
Pg(2,:)=pentagon([Pe([4 3],:);Pf(3,:)]);
Pg(3,:)=pentagon([Pe([6 5],:);Pf(5,:)]);
Pg(4,:)=pentagon([Pe([8 7],:);Pf(7,:)]);

Ph(5,:)=hexagon([Pf([1 10],:);Pg(5,:)]);%第3层6边形
Ph(1,:)=hexagon([Pf([3 2],:);Pg(1,:)]);
Ph(2,:)=hexagon([Pf([5 4],:);Pg(2,:)]);
Ph(3,:)=hexagon([Pf([7 6],:);Pg(3,:)]);
Ph(4,:)=hexagon([Pf([9 8],:);Pg(4,:)]);

%使球心落在原点
H=Ph(1,end)/2;
Pa(:,3)=Pa(:,3)-H; Pb(:,3)=Pb(:,3)-H;   Pc(:,3)=Pc(:,3)-H; Pd(:,3)=Pd(:,3)-H;
Pe(:,3)=Pe(:,3)-H; Pf(:,3)=Pf(:,3)-H;   Pg(:,3)=Pg(:,3)-H; Ph(:,3)=Ph(:,3)-H; 

if RorHorL=='R'
    R=sqrt(1/4/sin(36/180*pi)^2+H^2);
    Pa=Pa/R; Pb=Pb/R; Pc=Pc/R; Pd=Pd/R; 
    Pe=Pe/R; Pf=Pf/R; Pg=Pg/R; Ph=Ph/R; 
elseif RorHorL=='H'
    Pa=Pa/H; Pb=Pb/H; Pc=Pc/H; Pd=Pd/H; 
    Pe=Pe/H; Pf=Pf/H; Pg=Pg/H; Ph=Ph/H; 
% RorHorL=='L' 无需操作
end


%12个正5边形(从下到上)
flat5(:,:,12)=Ph;
flat5(:,:,1)=Pa;
flat5(:,:,2)=[Pb(1,:);Pc(1,:);Pd(10,:);Pd(9,:);Pc(10,:)];%第2层5边形
flat5(:,:,3)=[Pb(2,:);Pc(3,:);Pd(2,:);Pd(1,:);Pc(2,:)];
flat5(:,:,4)=[Pb(3,:);Pc(5,:);Pd(4,:);Pd(3,:);Pc(4,:)];
flat5(:,:,5)=[Pb(4,:);Pc(7,:);Pd(6,:);Pd(5,:);Pc(6,:)];
flat5(:,:,6)=[Pb(5,:);Pc(9,:);Pd(8,:);Pd(7,:);Pc(8,:)];
%----------------------------------------------------
flat5(:,:,7)=[Pg(1,:);Pf(2,:);Pe(2,:);Pe(1,:);Pf(1,:)];%第3层5边形
flat5(:,:,8)=[Pg(2,:);Pf(4,:);Pe(4,:);Pe(3,:);Pf(3,:)];
flat5(:,:,9)=[Pg(3,:);Pf(6,:);Pe(6,:);Pe(5,:);Pf(5,:)];
flat5(:,:,10)=[Pg(4,:);Pf(8,:);Pe(8,:);Pe(7,:);Pf(7,:)];
flat5(:,:,11)=[Pg(5,:);Pf(10,:);Pe(10,:);Pe(9,:);Pf(9,:)];


%20个正六边形
flat6(:,:,1)=[Pa([2 1],:);Pb(1,:);Pc([1 2],:);Pb(2,:)]; %第1层6边形
flat6(:,:,2)=[Pa([3 2],:);Pb(2,:);Pc([3 4],:);Pb(3,:)];
flat6(:,:,3)=[Pa([4 3],:);Pb(3,:);Pc([5 6],:);Pb(4,:)];
flat6(:,:,4)=[Pa([5 4],:);Pb(4,:);Pc([7 8],:);Pb(5,:)];
flat6(:,:,5)=[Pa([1 5],:);Pb(5,:);Pc([9 10],:);Pb(1,:)];
flat6(:,:,6)=[Pc([2 1],:);Pd(10,:);Pe([1 2],:);Pd(1,:)];%第2层6边形
flat6(:,:,7)=[Pc([4 3],:);Pd(2,:);Pe([3 4],:);Pd(3,:)];
flat6(:,:,8)=[Pc([6 5],:);Pd(4,:);Pe([5 6],:);Pd(5,:)];
flat6(:,:,9)=[Pc([8 7],:);Pd(6,:);Pe([7 8],:);Pd(7,:)];
flat6(:,:,10)=[Pc([10 9],:);Pd(8,:);Pe([9 10],:);Pd(9,:)];
%--------------------------------------------------------------
flat6(:,:,11)=[Pd([2 1],:);Pe(2,:);Pf([2 3],:);Pe(3,:)];%第3层6边形
flat6(:,:,12)=[Pd([4 3],:);Pe(4,:);Pf([4 5],:);Pe(5,:)];
flat6(:,:,13)=[Pd([6 5],:);Pe(6,:);Pf([6 7],:);Pe(7,:)];
flat6(:,:,14)=[Pd([8 7],:);Pe(8,:);Pf([8 9],:);Pe(9,:)];
flat6(:,:,15)=[Pd([10 9],:);Pe(10,:);Pf([10 1],:);Pe(1,:)];
flat6(:,:,16)=[Pf([3 2],:);Pg(1,:);Ph([1 2],:);Pg(2,:)];%第4层6边形
flat6(:,:,17)=[Pf([5 4],:);Pg(2,:);Ph([2 3],:);Pg(3,:)];
flat6(:,:,18)=[Pf([7 6],:);Pg(3,:);Ph([3 4],:);Pg(4,:)];
flat6(:,:,19)=[Pf([9 8],:);Pg(4,:);Ph([4 5],:);Pg(5,:)];
flat6(:,:,20)=[Pf([1 10],:);Pg(5,:);Ph([5 1],:);Pg(1,:)];


%画图
if draw==1
    draw_football(flat5,flat6);
end

end

%已知五边形的3点,求第2点连出的线段的另一端的坐标
%size(P3)=[3,3];
function P=P32P(P3) %P3右手定则的法向向球外

v1=P3(2,:)-P3(1,:);
v2=P3(2,:)-P3(3,:);
C=1/2/cos(54/180*pi); S=sqrt(1-C^2);
v3=vunit(cross(v1,v2));
P=vunit(v1+v2)*C+P3(2,:)+v3*S;

end

%已知5边形的3点, 求出第4点和第5点
function [P4,P5]=pentagon(P3)

v1=P3(2,:)-P3(1,:); 
v2=P3(3,:)-P3(2,:);
C=cos(72/180*pi);
P4=P3(3,:)+v2*C*2-v1;
v3=P4-P3(3,:);
P5=P4+v3*C*2-v2;

end

%%已知6边形的3点, 求出第4,5,6点
function [P4,P5,P6]=hexagon(P3)

v1=P3(2,:)-P3(1,:); 
v2=P3(3,:)-P3(2,:);
P4=P3(3,:)+v2-v1;
v3=P4-P3(3,:);
P5=P4+v3-v2;
v4=P5-P4;
P6=P5+v4-v3;

end