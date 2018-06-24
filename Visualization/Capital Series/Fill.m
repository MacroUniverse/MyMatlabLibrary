%fill的自定义形式
%size(P)=[N,2];
function h=Fill(P,varargin)
X=P(:,1); Y=P(:,2); 
if nargout>0
    h=fill(X,Y,varargin{:});
else
    fill(X,Y,varargin{:});
end
end