%plot3的自定义形式
%size(P)=[N,3];
function h=Plot3(P,varargin)

X=P(:,1); Y=P(:,2); Z=P(:,3);
if nargout>0
    h=plot3(X,Y,Z,varargin{:});
else
    plot3(X,Y,Z,varargin{:});
end

end