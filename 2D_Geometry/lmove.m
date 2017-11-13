%把平面射线(带方向的直线)向左移动一段距离d
%平面射线的格式是l=[m, n,theta]; 其中[m,n]是平面直角坐标, theta是与x轴的夹角
function l=lmove(l,d)
l(:,1)=l(:,1)-sin(l(:,3)).*d;
l(:,2)=l(:,2)+cos(l(:,3)).*d;
end