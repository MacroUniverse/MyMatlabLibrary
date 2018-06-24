%删除所有回车前所有空格
%若str是矩阵, 则先变为一行,用回车隔开.

function str=endSpace(str)

Size=size(str);

%str是矩阵
if Size(1)>1 && Size(2)>1
    str1=char(zeros(1,Size(1)*(Size(2)+1)));
    for ii=1:Size(1)
        temp=Size(2)+1;
        str1(temp*(ii-1)+1:temp*ii)=[str(ii,:) char(13)];
    end
    str=str1; clear str1;
end

mark=true(size(str));
ind=strfind(str,char(13));
for ii=1:numel(ind)
    jj=ind(ii)-1;
    while jj>0 && str(jj)==32
        jj=jj-1;
    end
    mark(jj+1:ind(ii)-1)=false;
end
str=str(mark);

end