close all;
%Specify the Potential Function
V0=2000;
V=@(x) V0*((1/x)^12-2*(1/x)^6);
%The range of x
xspan=[0.7,2];
%Plot the potential function
fplot(V,xspan); axis([xspan(1),xspan(2),-1.1*V0,1.1*V0]); 
title('potential function');
%compare two shots at this point
x_mid=1.3;
%The range of energy
Espan=[-0.99*V0,-0.08*V0];
%Divide the E range into this number of interval to find root (eigen value)
resolution=70;
%boundary value of wave function
epsilon=0.00001;
% step length to solve 
dx=0.001;
%The root of this function is Energy eigen value
F0=@(E) trial(E,V,xspan,x_mid,epsilon,dx);

%Solve for the root/ Energy levels
E=fzeroN(F0, Espan, resolution);

%Plot the wave functions
ii=1;
while ii<=numel(E)
   [~, x1,Y1,x2,Y2]=trial(E(ii),V,xspan,x_mid,epsilon,dx);
   % make sure the wave function is smooth
   if abs(Y1(end)-Y1(end-1)-(Y2(end-1)-Y2(end))) > abs(Y1(end)-Y1(end-1))/100
       E=E([1:ii-1,ii+1:end]);
       [~, x1,Y1,x2,Y2]=trial(E(ii),V,xspan,x_mid,epsilon,dx);
   end
   figure; hold on;
   plot(x1,Y1);
   plot(x2,Y2);
   title(['V0=' num2str(V0) '; E=' num2str(E(ii)) ]);
   ii=ii+1;
end

