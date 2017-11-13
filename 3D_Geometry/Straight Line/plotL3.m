%画出空间射线(六参数),输入要画的长度
%size(L)=[N,6]
%size(Len)=[N,1]或size(Len)=[1,1];

function plotL3(L,Len,varargin)

N=size(L,1);

P1=L(:,1:3);
P2=LR2P(L,Len);

for ii=1:N
    Plot3([P1(ii,:);P2(ii,:)],varargin{:});
end

end

