%边边角函数
%解三角形第三边
%size(b3)==[2,1],无解补nan
%一个解时,b3(2)=nan
%解出的b3(1)>b3(2)
%path=0,输出两个解, path=1,输出第一个解, path=2,输出第二个解
%size(b1)=size(b2)=[N,1]; size(path)=1;

function b3=bbj(b1,b2,j,path)

N=numel(b1);
if path==0
    b3=zeros(N,2);
else
    b3=zeros(N,1);
end

for ii=1:N
    b3(ii,:)=bbj1(b1(ii),b2(ii),j(ii),path);
end

end


function b3=bbj1(b1,b2,j,path)
b3=nan(2,1); %预设无解

if any(isnan([b1,b2]))
    if path~=0
        b3=nan; return
    else
        b3=[nan nan]; return
    end
end


c=cos(j);
s=sqrt(1-c^2);
delta=b1^2-b2^2*s^2;

if delta>0
    b2c=b2*c;
    sqrtdelta=sqrt(delta);
    if b2-b1>-1e-7
        b3(1)=b2c+sqrtdelta;
        b3(2)=b2c-sqrtdelta;
    else
        b3(1)=b2c+sqrtdelta;
        b3(2)=nan;
    end
elseif delta>-1e-12 %delta==0 (忽略微小误差,结果误差半径1e-7)
   b3(:)=b2*c;
end


%若都不满足, 则无解

%选择输出
if path~=0
    b3=b3(path);
end

end

