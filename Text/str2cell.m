%cell2str的逆向函数
%把用回车符char(13)隔开的字符串分别装进元胞数组的元胞中
%忽略所有多余的回车, 保证每个元胞里面都有内容

function Cell=str2cell(str)

%1.如果是char矩阵, 拼成一行, 用回车隔开;
%2.消除回车前面的连续空格;
str=endSpace(str);
%所有连续回车变成单回车, 且保证开头无回车结尾有回车
str=monoCR(str);

%分段装进元胞数组
ind=strfind(str,char(13));
Ncell=numel(ind);
Cell=cell(Ncell,1);
ind=[0 ind];
for ii=1:Ncell
    Cell{ii}=str(ind(ii)+1:ind(ii+1)-1);
end

end