%画出矢量V
function PlotV3(V,varargin)
N=size(V,1);
for ii=1:N
    Plot3([0 0 0; V(ii,:)],varargin{:});
end
end