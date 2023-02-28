%制作3D模型展示avi的程序模板
%具体应用见draw_football程序

%如果输入vz和theta,画出静态的模型. 先绕z轴转动thetavz, 再把轴转向vz方向; vz不为零即可.
%如果输入vz=Omega,theta=omega, 则z轴以Omega角速度旋转, 模型以角速度omega自转;

%rec=1时, 在桌面生成录像

function mov=functionName(~,~,vz,theta,T,rec) %忽略错误

%设置播放帧率(可以是非整数)
f=30;

%判断模式, 初始化
if nargin==6 %avi模式, 生成avi视频
    flag='a'; 
    Omega=vz; %轴倾斜角速度
    omega=theta;%绕轴角速度
    time1=tic; %开始播放的时间
    Axis1=[0 0 1]; %轴
    kk_max=floor(f*T); %视频总帧数
    mov(1:kk_max)=struct('cdata', [], 'colormap', []); %视频矩阵
    
elseif nargin==5%movie模式, 动画演示或视频
    flag='m'; 
    Omega=vz; %轴倾斜角速度
    omega=theta;%绕轴角速度
    time1=tic; %开始播放的时间
    Axis1=[0 0 1]; %轴
    kk_max=floor(f*T); %视频总帧数
    
elseif nargin==4 %static模式, 旋转后的静态图像
    flag='s'; 
    kk_max=1; %视频总帧数
    
elseif nargin==2 %origin模式, 原始静态图像
    flag='o'; 
    kk_max=1; %视频总帧数
end

kk=0; %当前帧数
warning_mark=false;

%设置窗口
hf=figure;  
axis([-1.5 1.5 -1.5 1.5 -1.5 1.5]); view([26,38]); axis equal; axis on; grid on;
set(gca,'CameraViewAngleMode','manual');
input('调整窗口大小,按回车开始');
figure(hf);

%rect(1:2)是figure的左下角在电脑屏幕上的坐标, rect(3:4)是axis的右上角的
set(hf,'unit','pixels'); f_posi=get(hf,'position');%刚好消除figure最外层的边框!(忽略掉窗口边界).
rect(1:2)=f_posi(1:2);
rect(3:4)=f_posi(1:2)+f_posi(3:4)-1;

%播放循环, 一个循环播放一帧图像
while kk+1<=kk_max
    %转动模型所有坐标
    if flag=='m' || 'a'
        Axis=Axis1;
        %Axis绕y轴旋转得到Axis1
        Axis1=vturn(Axis,[0 1 0],Omega/f);
        %模型绕Axis旋转
        []=turn(~,~,~,Axis,omega/f);
        %%模型随着Axis转到Axis1
        []=turn(~,~,~,Axis,Axis1);
    elseif flag=='s'
        []=turn(~,~,~,[0 0 1],theta);
        []=turn(~,~,~,[0 0 1],vz);
    end
    
    %画图
    cla; hold on; %清除模型,坐标轴不变
        plot3(
        fill3(
        ...
    light
    kk=kk+1; %当前帧数
    
    %播放控制
    if flag=='m' %动画模式
        now=toc(time1);
        temp=kk/f-now; %该周期中画完图后余下的时间
        if temp>0
            pause(temp);%补足该帧剩下的时间
        else
            warning_mark=true; %如果画图太慢, 在程序结束后警告;    
        end
        
    elseif  flag=='a' %录像模式
        pause(0.05); %等待作图
        temp=printScreen; %截屏
        %选取axis所在的区域rect
        Size=size(temp);%屏幕尺寸
        temp=temp(Size(1)-rect(4)+1:Size(1)-rect(2)+1, rect(1):rect(3),:);
        mov(kk).cdata=temp;
    end
    
end

%频率极限警告(注意偶尔卡一帧也会警告)
if warning_mark
    warning('帧数太高, 不能播放动画, 在line11设置');
end
%生成视频
if flag=='a'
    cf; movie2avi(mov,'rotating_football','compression','None','fps',f);
end

end