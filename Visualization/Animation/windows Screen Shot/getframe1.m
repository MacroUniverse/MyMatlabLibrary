%截取当前figure的截图(rgb图)
%因为getframe有时候不管用(截出来是空白的), 可以用这个代替
%如果输入一个h(figure的handle,就是用于figure(h)的)就截取h的图
%如果不输入h, 就截取当前的figure,figure(gcf).(gcf=get current figure)

%该函数调用了printScreen函数, 继而调用了一个java脚本实现windows截屏
%再获取figure的位置信息, 把截屏中的figure部分截取出来.
%速度会比getframe慢很多

function I=getframe1(hf)

if nargin==0
    hf=gcf;
end
    
%获取hf的position属性(刚好消除figure最外层的边框, 忽略掉窗口边界.)
set(hf,'unit','pixels'); f_posi=get(hf,'position');
rect(1:2)=f_posi(1:2);
rect(3:4)=f_posi(1:2)+f_posi(3:4)-1;
figure(hf);
pause(0.05); %等待作图,等待figure弹出.
I=printScreen; %截屏
%选取axis所在的区域rect
Size=size(I);%屏幕尺寸
I=I(Size(1)-rect(4)+1:Size(1)-rect(2)+1, rect(1):rect(3),:);
end