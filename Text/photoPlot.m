%以相片矩阵的Ind或Sub为坐标的plot函数
%程序从当前的图片对象中提取矩阵尺寸
%格式
% photoPlot(Ind)
% photoPlot(r,c)
%photoPlot(...., plot的设置元胞) 注意设置是元胞数组!

function photoPlot(varargin)

hold on;
Size=photoSize;

flag=isa(varargin{end},'cell');

if nargin-flag ==1
    [y,x]=ind2sub(Size,varargin{1});
elseif nargin-flag==2
    y=varargin{2}; x=varargin{1};
end

if flag
    plot(x,y,varargin{end}{:});
else
    plot(x,y);
end

end