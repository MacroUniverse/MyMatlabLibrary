%两条nl格式的直线求出交点d (nl格式: n是直线上离原点最近的点坐标, l是直线到原点的距离)
%size(nl1)=size(nl2)=[N,3]

function xy=nl22d(nl1,nl2)

N=size(nl1,1);
xy=zeros(N,2);

for ii=1:N
   XY=[nl1(ii,[1 2]);nl2(ii,[1 2])]\[nl1(ii,3);nl2(ii,3)];
   xy(ii,:)=XY';
end

end