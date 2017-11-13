%画pmd调试
%先准备好P,pmd0

setfigure 3D; axis off
pmd1=pmd0; pmd1(4,:)=P;
    
%[x,y]=board; plotnet(x,y);%画出标定板
Extract_pmd0
Line1=P22L(P,P1); Line2=P22L(P,P2); Line3=P22L(P,P3);

Lm1=max(Ls31,Ls12); plotL3(Line1,Lm1,'k'); %画出三条棱
Lm2=max(Ls12,Ls23); plotL3(Line2,Lm2,'k'); 
Lm3=max(Ls23,Ls31); plotL3(Line3,Lm3,'k'); 

Pt1=LR2P(Line1,Lm1*1.1); Text(Pt1,'Line1'); %标出L1,Line2,Line3
Pt2=LR2P(Line2,Lm2*1.1); Text(Pt2,'Line2');
Pt3=LR2P(Line3,Lm3*1.1); Text(Pt3,'Line3');

temp=[pmd0(1:3); P; Pt1; Pt2; Pt3];
axis([min(temp(:,1)),max(temp(:,1)),...
        min(temp(:,2)),max(temp(:,2)),...
        min(temp(:,3)),max(temp(:,3))]);

Pt1_2=LR2P(Line1,Lt12); Ps1_2=LR2P(Line1,Ls12); %找到区间点
Pt1_3=LR2P(Line1,Lt31); Ps1_3=LR2P(Line1,Ls31);
Pt2_3=LR2P(Line2,Lt23); Ps2_3=LR2P(Line2,Ls23);
Pt2_1=LR2P(Line2,Lt12); Ps2_1=LR2P(Line2,Ls12);
Pt3_1=LR2P(Line3,Lt31); Ps3_1=LR2P(Line3,Ls31);
Pt3_2=LR2P(Line3,Lt23); Ps3_2=LR2P(Line3,Ls23);

Marker={'Marker','.','MarkerSize',8};
Plot3([Pt1_2; Ps2_1],'r',Marker{:}); Plot3([Ps1_2; Pt2_1],'r',Marker{:}); %画出区间关系
Plot3([Pt2_3; Ps3_2],'g',Marker{:}); Plot3([Ps2_3; Pt3_2],'g',Marker{:});
Plot3([Pt3_1; Ps1_3],'b',Marker{:}); Plot3([Ps3_1; Pt1_3],'b',Marker{:});

 %画出所需解的位置
Plot3([P1;P2],'LineStyle','-.','LineWidth',2,'Color','r',Marker{:});
Plot3([P2;P3],'LineStyle','-.','LineWidth',2,'Color','g',Marker{:});
Plot3([P3;P1],'LineStyle','-.','LineWidth',2,'Color','b',Marker{:});

%显示domain编号, 显示path
domain=0;

if L1>Lt12 && L2>Lt12
    domain=domain+9;
elseif L1>L12 && L2<Lt12
    domain=domain+18;
end

if L2>Lt23 && L3>Lt23
    domain=domain+3;
elseif L2>L23 && L3<Lt23
    domain=domain+9;
end

if L3>Lt31 && L1>Lt31
    domain=domain+1;
elseif L3>L31 && L1<Lt31
    domain=domain+3;
end

[path,path2]=Path(domain);

title(['domain=' num2str(domain) '  path=' num2str(path) ' (' num2str(path2) ')']); 

