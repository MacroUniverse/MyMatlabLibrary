%计算两矢量的夹角
%A和B必须是行矢量或者列矢量
%length(A)=length(B)>=2
%要用到自编mag函数
function theta=vang(A,B)
N=size(A,1);
if N==1
    theta=acos(dot(A,B)/vmag(A)/vmag(B));
    theta=real(theta);
elseif N>1
    theta=zeros(N,1);
    AdotB=dot(A',B');
    magA=vmag(A);
    magB=vmag(B);
    for n=1:N
        theta(n)=acos(AdotB(n)/magA(n)/magB(n));
    end
end
end