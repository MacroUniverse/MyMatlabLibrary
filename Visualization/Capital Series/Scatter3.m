%scatter3的自定义函数
%size(D)=[N,3];
function h=Scatter3(D,varargin)
X=D(:,1); Y=D(:,2);Z=D(:,3);
if nargout>0
    h=scatter3(X,Y,Z,varargin{:});
else
    scatter3(X,Y,Z,varargin{:});
end
end