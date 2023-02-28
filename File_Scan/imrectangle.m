%任意四边形灰度图像转换成矩形图像
%算法: 四边形ABCD, (x,y)所在的点就是, 在AB上取E, AE/AB=x; 在DC上取F, 使DF/DC=x
%连结EF, 该线段就是x坐标所在的线段
%同理得出y坐标所在的线段
%两条线段的交点就是(x,y)
%sub4(1,:)是四边形左上角的点的矩阵索引, 逆时针以此类推.
%注意! 由于编译不能输入三维矩阵, I必须是二维矩阵

function I1=imrectangle(I,sub4,size1)
p1=sub4(1,:); p2=sub4(2,:); p3=sub4(3,:); p4=sub4(4,:);
I1=cast(zeros(size1),class(I));
for r=1:size1(1) 
    for c=1:size1(2)
        Rr=r/size1(1); Rc=c/size1(2);
        p12=(1-Rr)*p1+Rr*p2;
        p23=(1-Rc)*p2+Rc*p3;
        p34=(1-Rr)*p4+Rr*p3;
        p41=(1-Rc)*p1+Rc*p4;
        temp=round(p42p([p12; p23; p34; p41]));
        I1(r,c)=I(temp(1),temp(2));
    end
end
end