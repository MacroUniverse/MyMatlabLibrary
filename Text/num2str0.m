%用于生成 文件名中的编号
%输入一个整数向量,通过补零的方式,输出等长的字符编号(元胞)
function [str,Lmax]=num2str0(num)

N=numel(num);
num=num2cell(num);
str=cell(N,1);
for ii=1:N
    str{ii}=num2str(num{ii});
end
Lmax=max(max(cellfun(@numel,str)));
for ii=1:numel(str)
   L=numel(str{ii});
   str{ii}=[repmat('0',1,Lmax-L) str{ii}];
end

end