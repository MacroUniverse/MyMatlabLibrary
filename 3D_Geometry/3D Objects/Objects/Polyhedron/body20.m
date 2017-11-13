%计算正二十面体的所有坐标, 并选择是否画图.
%RorHorL='R'时, 外接球的半径为R为1.
%RorHorL='H'时, 内接球的半径H为1.
%RorHorL='L'时, 棱长L为1.
%draw=1或者true时, 画图, 否则不画图

function [Pa,Pb,Pc,Pd]=body20(RorHorL,draw)

Pa=[0,sqrt(3)/2,0;-1/2,0,0;1/2 0 0];

Pb(1,:)=sphere_tri2p(Pa([1 3 2],:));
Pb(2,:)=sphere_tri2p(Pa([2 1 3],:));
Pb(3,:)=sphere_tri2p(Pa([3 2 1],:));

Pc(1,:)=sphere_tri2p([Pb(1,:);Pa([1 2],:)]);
Pc(2,:)=sphere_tri2p([Pb(2,:);Pa([2 3],:)]);
Pc(3,:)=sphere_tri2p([Pb(3,:);Pa([3 1],:)]);

Pd(1,:)=sphere_tri2p([Pb(2,:);Pa(3,:);Pc(2,:)]);
Pd(2,:)=sphere_tri2p([Pb(3,:);Pa(1,:);Pc(3,:)]);
Pd(3,:)=sphere_tri2p([Pb(1,:);Pa(2,:);Pc(1,:)]);

h=Pd(1,end)/2; 
Pa(:,3)=Pa(:,3)-h; Pb(:,3)=Pb(:,3)-h; Pc(:,3)=Pc(:,3)-h; Pd(:,3)=Pd(:,3)-h;
temp=1/2/sqrt(3);
Pa(:,2)=Pa(:,2)-temp;Pb(:,2)=Pb(:,2)-temp;Pc(:,2)=Pc(:,2)-temp;Pd(:,2)=Pd(:,2)-temp;

if RorHorL=='R'
    R=sqrt(1/3+h^2/4);
    Pa=Pa/R; Pb=Pb/R; Pc=Pc/R; Pd=Pd/R;
elseif RorHorL=='H'
    Pa=Pa/h; Pb=Pb/h; Pc=Pc/h; Pd=Pd/h;
% RorHorL=='L' 无需操作
end

if draw==1
    flat3(:,:,20)=Pd;
    flat3(:,:,1)=Pa;
    flat3(:,:,2)=[Pa([1 2],:);Pb(1,:)];
    flat3(:,:,3)=[Pa([2 3],:);Pb(2,:)];
    flat3(:,:,4)=[Pa([3 1],:);Pb(3,:)];
    flat3(:,:,5)=[Pa(1,:);Pb(1,:);Pc(3,:)]; flat3(:,:,6)=[Pb(1,:);Pa(2,:);Pc(1,:)];
    flat3(:,:,7)=[Pa(2,:);Pb(2,:);Pc(1,:)]; flat3(:,:,8)=[Pb(2,:);Pa(3,:);Pc(2,:)];
    flat3(:,:,9)=[Pa(3,:);Pb(3,:);Pc(2,:)]; flat3(:,:,10)=[Pb(3,:);Pa(1,:);Pc(3,:)];
    flat3(:,:,11)=[Pc(3,:);Pb(1,:);Pd(3,:)]; flat3(:,:,12)=[Pb(1,:);Pc(1,:);Pd(3,:)];
    flat3(:,:,13)=[Pc(1,:);Pb(2,:);Pd(1,:)]; flat3(:,:,14)=[Pb(2,:);Pc(2,:);Pd(1,:)];
    flat3(:,:,15)=[Pc(2,:);Pb(3,:);Pd(2,:)]; flat3(:,:,16)=[Pb(3,:);Pc(3,:);Pd(2,:)];
    flat3(:,:,17)=[Pc(1,:);Pd(3,:);Pd(1,:)];
    flat3(:,:,18)=[Pc(2,:);Pd(1,:);Pd(2,:)];
    flat3(:,:,19)=[Pc(3,:);Pd(2,:);Pd(3,:)];
    
    figure; hold on;  axis equal; axis off; grid on;
    set(gca,'CameraViewAngleMode','manual');
    
    for ii=1:20
        temp=flat3(:,:,ii);
        fill3(temp(:,1),temp(:,2),temp(:,3),'w','FaceAlpha',1,'EdgeAlpha',0.9,'LineWidth',2);
    end
    
end

end

%已知三角球体上的一个三角形, 求出另一个点

function P=sphere_tri2p(P3) %P3右手定则的法向向球外
v1=P3(1,:)-P3(2,:); v2=P3(3,:)-P3(2,:);
v3=cross(v1,v2);
C=8/3*sin(54/180*pi)^2-1;
S=sqrt(1-C^2);
P=(v1+v2)/2*(C+1)+v3*S+P3(2,:);
end
