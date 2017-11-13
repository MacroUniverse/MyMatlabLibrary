%Surf的自定义形式
%size(P)=[N,3];
%ind的是单下标引索组成的网
function h=Surf(P,ind,varargin)
X=P(:,1); Y=P(:,2); Z=P(:,3);
X=X(ind); Y=Y(ind); Z=Z(ind);
if nargout>0
    h=surf(X,Y,Z,varargin{:});
else
    surf(X,Y,Z,varargin{:});    
end
end