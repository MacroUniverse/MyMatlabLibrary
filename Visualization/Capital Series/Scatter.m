%scatter的自定义函数
%size(D)=[N,2];
function h=Scatter(D,varargin)
X=D(:,1); Y=D(:,2);
if nargout>0
    h=scatter(X,Y,varargin{:});
else
    scatter(X,Y,varargin{:});
end
end