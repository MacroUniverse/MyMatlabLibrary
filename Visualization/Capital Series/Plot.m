%plot的自定义形式
%size(D)=[N,2];
function h=Plot(D,varargin)
X=D(:,1); Y=D(:,2);
if nargout>0
    h=plot(X,Y,varargin{:});
else
    plot(X,Y,varargin{:});
end
end