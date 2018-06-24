%text的自定义函数
%Text(D,StringCell....)     size(D)=[N,2];
%Text(P, StringCell....)    size(P)=[N,3];
%numel(StringCell)=N;

function h=Text(D,StringCell,varargin)
if size(D,2)==2
    X=D(:,1); Y=D(:,2);
    h=text(X,Y,StringCell,varargin{:});
else
    X=D(:,1); Y=D(:,2); Z=D(:,3);
    h=text(X,Y,Z,StringCell,varargin{:});
end
end