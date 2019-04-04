%画出足�?�,flat5是所有的5边形,第n个5边形的第ii个点的�??标就是flat5(ii,:,n)
%flat6是所有6边形,类比flat5.

%如果输入vz和theta,画出�?��?的足�?�. 先绕z轴转动thetavz, �?把轴转�?�vz方�?�; vz�?为零�?��?�.
%如果输入vz=Omega,theta=omega, 则z轴以Omega角速度旋转, 足�?�以角速度omega自转; 动画时间为T

%rec=1时, 在桌�?�生�?录�?

%生�?视频的例�?:
 %[Pa,Pb,Pc,Pd,Pe,Pf,Pg,Ph,flat5,flat6]=body60('R',0);
 %draw_football(flat5,flat6,pi/6,pi/3,5,1)

function mov=draw_football(flat5,flat6,vz,theta,T,rec) %忽略错误
%设置播放帧率(�?�以是�?�整数)
f=20;
%f=7;%实时播放的频率

%判断模�?, �?始化
if nargin==6 %avi模�?, 生�?avi视频
    flag='a'; 
    Omega=vz; %轴倾斜角速度
    omega=theta;%绕轴角速度
    Axis1=[0 0 1]; %轴
    kk_max=floor(f*T); %视频总帧数
    mov(1:kk_max)=struct('cdata', [], 'colormap', []); %视频矩阵
    
elseif nargin==5%movie模�?, 动画演示或视频
    flag='m'; 
    Omega=vz; %轴倾斜角速度
    omega=theta;%绕轴角速度
    Axis1=[0 0 1]; %轴
    kk_max=floor(f*T); %视频总帧数
    
elseif nargin==4 %static模�?, 旋转�?�的�?��?图�?
    flag='s'; 
    kk_max=1; %视频总帧数
    Axis1=[0 0 1]; %轴
    
elseif nargin==2 %origin模�?, 原始�?��?图�?
    flag='o'; 
    kk_max=1; %视频总帧数
    Axis1=[0 0 1]; %轴
end

kk=0; %当�?帧数
warning_mark=false;

%设置窗�?�
hf=figure;  
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]); 
 axis on;
view([26,38]); axis equal; grid on;
set(gca,'CameraViewAngleMode','manual');
input('调整窗�?�大�?,按回车开始');
figure(hf);

%rect(1:2)是figure的左下角在电脑�?幕上的�??标, rect(3:4)是axis的�?�上角的
set(hf,'unit','pixels'); f_posi=get(hf,'position');%刚好消除figure最外层的边框!(忽略掉窗�?�边界).
rect(1:2)=f_posi(1:2);
rect(3:4)=f_posi(1:2)+f_posi(3:4)-1;

time1=tic; %开始播放的时间
%播放循环, 一个循环播放一帧图�?
while kk+1<=kk_max
    %转动足�?�所有�??标
    if flag=='m' || flag=='a'
        Axis=Axis1;
        %Axis绕y轴旋转得到Axis1
        Axis1=vturn(Axis,[0 1 0],Omega/f);
        %足�?�绕Axis旋转
        [flat5(:,1,:),flat5(:,2,:),flat5(:,3,:)]=turn(flat5(:,1,:),flat5(:,2,:),flat5(:,3,:),Axis,omega/f);
        [flat6(:,1,:),flat6(:,2,:),flat6(:,3,:)]=turn(flat6(:,1,:),flat6(:,2,:),flat6(:,3,:),Axis,omega/f);
        %%足�?��?�?�Axis转到Axis1
        [flat5(:,1,:),flat5(:,2,:),flat5(:,3,:)]=turn(flat5(:,1,:),flat5(:,2,:),flat5(:,3,:),Axis,Axis1);
        [flat6(:,1,:),flat6(:,2,:),flat6(:,3,:)]=turn(flat6(:,1,:),flat6(:,2,:),flat6(:,3,:),Axis,Axis1);
    elseif flag=='s'
        [flat5(:,1,:),flat5(:,2,:),flat5(:,3,:)]=turn(flat5(:,1,:),flat5(:,2,:),flat5(:,3,:),[0 0 1],theta);
        [flat5(:,1,:),flat5(:,2,:),flat5(:,3,:)]=turn(flat5(:,1,:),flat5(:,2,:),flat5(:,3,:),[0 0 1],vz);
    end
    
    %画图
    cla; hold on; %清除足�?�,�??标轴�?�?�
    for ii=1:size(flat5,3)
        temp=flat5(:,:,ii);
        Fill3(temp,'k');
    end

    for ii=1:size(flat6,3)
        temp=flat6(:,:,ii);
        Fill3(temp,'w','FaceAlpha',0.85);
    end
    light
    kk=kk+1; %当�?帧数
    
    %播放控制
    if flag=='m' %动画模�?
        now=toc(time1);
        temp=kk/f-now; %该周期中画完图�?�余下的时间
        if temp>0
            pause(temp);%补足该帧剩下的时间
        else
            warning_mark=true; %如果画图太慢, 在程�?结�?��?�警告;    
        end
        
    elseif  flag=='a' %录�?模�?
        pause(0.05); %等待作图
        temp=printScreen; %截�?
        %选�?�axis所在的区域rect
        Size=size(temp);%�?幕尺寸
        temp=temp(Size(1)-rect(4)+1:Size(1)-rect(2)+1, rect(1):rect(3),:);
        mov(kk).cdata=temp;
    end
    
end

%播放结�?�
% if  flag=='a' %制作电影;
%     frame=mov(1:kk);
%     cf; movie2avi(frame,'rotating_football','compression',....
%                                   'Cinepak','fps',20,'quality',100); 
% end

if warning_mark
    warning('帧数太高, �?能播放动画, 在line11设置');
end

if flag=='a'
    cf; movie2avi(mov,'rotating_football','compression','None','fps',f);
end

end