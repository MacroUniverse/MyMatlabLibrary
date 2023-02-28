%精确画坐标轴
%话说,这个属性太多了,能不能创建成object啊. 就是可以用"属性名","属性值"来控制属性的.
%记得应该是可以的. 找找画图说明吧.
%不过目前还是写成普通函数吧.
%如果不输入Xticks,Yticks,就不显示刻度和标度
%如果输入Xtickstext,Ytickstext,就是自定义内容.
%digit是刻度值的有效数字, 不输默认是2
function FineAxes(Xstart,Xend,Ystart,Yend,Xticks,Yticks,digit,Xtickstext,Ytickstext)
%画x轴y轴箭头,使用较长的箭头的配置
Lx=abs(Xend-Xstart); Ly=abs(Yend-Ystart);
L=max(Lx,Ly);
thickness=L*0.005;
Ltriangle=thickness*5;
Htriangle=thickness*3;
FineArrow([Xstart,0],[Xend,0],thickness,Ltriangle,Htriangle); %画x轴
FineArrow([0,Ystart],[0,Yend],thickness,Ltriangle,Htriangle); %画y轴
%画刻度,默认的刻度线长度等于箭头宽度, 粗细等于坐标轴粗细的2/3;
Nxtick=numel(Xticks); Nytick=numel(Yticks);
for ii=1:Nxtick
    FineLine([Xticks(ii),-Htriangle/2],[Xticks(ii),Htriangle/2],thickness*2/3);
end
for ii=1:Nytick
    FineLine([-Htriangle/2,Yticks(ii)],[Htriangle/2,Yticks(ii)],thickness*2/3);
end

end