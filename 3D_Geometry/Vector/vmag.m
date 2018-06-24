%计算矢量模长
%当v是单个矢量时,不分行矢量与列矢量,维数nd>1
%当v是数组时,size可以是[N,nd]
%算法sqrt(dot(v,v))

function mag=vmag(v)

if ndims(v)==1
    mag=sqrt(dot(v,v));
else
    mag=sqrt(dot(v',v'))';
end
