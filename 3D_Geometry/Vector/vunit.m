%计算单位矢量
%当v是单个矢量时,不分行矢量与列矢量,维数ncolumn>1
%当v是数组时,size可以是[N,nd]
%如果是零矢量,返回零矢量

function unit=vunit(v)
if isvector(v)==1
    if vmag(v)==0
        unit=zeros(size(v));
    else
       unit=v/vmag(v);
    end
else
    mag=vmag(v);
    mag(mag==0)=inf;
    mag=repmat(mag,1,size(v,2));
    unit=v./mag;
end

end