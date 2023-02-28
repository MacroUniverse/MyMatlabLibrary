%截取figure框内的截图, 类比printScreen

function I=printFigure

hf=gcf;
set(hf,'unit','pixels'); f_posi=get(hf,'position');%刚好消除figure最外层的边框!(忽略掉窗口边界).
rect(1:2)=f_posi(1:2);
rect(3:4)=f_posi(1:2)+f_posi(3:4)-1;
I=printScreen; %截屏
%选取axis所在的区域rect
Size=size(I);%屏幕尺寸
I=I(Size(1)-rect(4)+1:Size(1)-rect(2)+1, rect(1):rect(3),:);


end