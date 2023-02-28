%二值图的"与缩小"
%把二值图缩小整数倍a
%每一个a*a的方格中, 只有全都是白的缩小后才是白的, 否则是黑的.
a=3;
Size=size(I);
I1=true(floor(Size(1)/a),floor(Size(2)/a));
for ii=1:floor(Size(1)/a)%每个ii是三列
    for jj=1:floor(Size(2)/a)%每个jj是三行
        temp=BW(a*(ii-1)+1:a*ii, a*(jj-1)+1:a*jj);
        I1(ii,jj)=all(temp(:)); %全都是白的才算白的
    end
end