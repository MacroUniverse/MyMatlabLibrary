% Function Integral Transform

% Fx is the function to be transformed. F(x)
% kernal is the function kernal(x,y)
% xspan is the range to be integrated
% gRelativeErr is the relative error of the integration.
function Gy=fTransform(kernal,Fx,xspan,y,gRelativeErr)
Gy=zeros(size(y)); 
for ii=1:numel(y)
    Gy(ii)=integral(@(x) kernal(x,y(ii)).*Fx(x) ,xspan(1),xspan(2),'Reltol',gRelativeErr);
end
end