%分段函数画图
%Nplot是描点的个数, 如果使用flag, 个数加倍
%FunCell 是函数句柄的1*n元胞, partition是1*(n+1)向量, 一一对应
%flag可选, 如果flag='odd',画奇函数. flag='even',画偶函数. 此时partition(1)必须为0.
%varargin是画图里面的option.
%
%示例:
%f1=@(x) sin(x); f2=@(x) cos(x); plotPW(300,{f1,f2},[0 pi 2*pi],'even','r')

function plotPW(Nplot,FunCell,partition,flag,varargin)

Nfun=numel(FunCell);
x=linspace(partition(1),partition(end),Nplot);
y=zeros(size(x));
for ii=1:Nfun %第ii个函数
    mark= partition(ii)<=x & x<=partition(ii+1);
    y(mark)=arrayfun(FunCell{ii},x(mark));
end
figure; hold on; grid on
plot(x,y,varargin{:});
if exist('flag','var')
    if strcmp(flag,'odd')
        plot(-x,-y,varargin{:});
    else
        plot(-x,y,varargin{:});
    end

end