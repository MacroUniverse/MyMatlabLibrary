%getframe取得Ind图像
%(我很好奇如果getframe自己没有这个功能, 为什么还要有colormap呢?但是我找不到..)
function frame=getframeInd(N,varargin)

frame=getframe(varargin{:});
[frame.cdata,frame.colormap]=rgb2ind(frame.cdata,N);

end