%在逻辑矩阵中按ind顺序找到连续N个真值

function varargout=findN(M,N)

kk=0; flag=false; ind=0;
for ii=1:numel(M)
    if M(ii)==true
        if flag==false
            flag=true; ind=ii;
        end
        kk=kk+1;
    else %M(ii)==false
        if flag==true
             flag=false;
        end
        kk=0;
    end
    if kk>=N
        break
    end
end

if kk<N
    varargout={}; return
end

if nargout==1
    varargout{1}=ind;
else
    [varargout{1:2}]=ind2sub(size(M),ind);
end