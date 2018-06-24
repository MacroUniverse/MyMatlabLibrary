%最小二乘法线性拟合, 计算误差
%根据KSU教材error analysis 编写

function [k,b,Sigma_y,Sigma_k,Sigma_b]=linearfit(x,y)

N=numel(x);
Mx=mean(x);
My=mean(y);
Mx2=mean(x.^2);
Mxy=mean(x.*y);

k=(Mxy-Mx*My)/(Mx2-Mx^2);
b=My-k*Mx;

Sigma_y=sqrt(sum((y-b-k*x).^2)/(N-2));
Sigma_k=Sigma_y*sqrt(1/N/(Mx2-Mx^2));
Sigma_b=Sigma_y*sqrt(Mx2/N/(Mx2-Mx^2));

end
