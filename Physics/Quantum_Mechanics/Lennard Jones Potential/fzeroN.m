%二分法求函数在一个区间内的所有根
%fun是函数句柄
%interval是寻根的区间
%resolution是二分法的区间数

function roots=fzeroN(fun,interval,resolution)

%判断二分法的解的范围
x=linspace(interval(1),interval(end), resolution);
y=arrayfun(fun,x);
figure; plot(x,y,'+-')
title('the function to be find zeros of')
Sign=sign(y);
ind=find(Sign(1:end-1).*Sign(2:end)<0); %有根的区间编号

%用二分法求解每个区间的跟
roots=zeros(size(ind));
for ii=1:numel(ind)
    roots(ii)=fzero(fun,[x(ind(ii)),x(ind(ii)+1)]);
end
end