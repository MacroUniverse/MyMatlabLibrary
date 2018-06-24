
function plot_fourier

interval=[-2*pi 2*pi];
N=500;
n_max=50;
x=linspace(interval(1),interval(2),N);
y=zeros(1,N);

for ii=1:N;
    y(ii)=f(x(ii),n_max);
end

figure;plot(x,y); grid on;
%axis([-8,8,-1.5,1.5]);
axis([-2*pi,2*pi,0,1.1]);
end

function y=f(x,n_max)%求一个值
y = coefficient(0)/2;
for n=1:n_max
    [an,bn]=coefficient(n);
    y=y+an*sin(n*x)+bn*cos(n*x);
end
end

function [a,b]=coefficient(n) 

if n == 0  % first term *2
    a = 4/pi; b = 0;
elseif mod(n,2)==1 % odd n
    a=0; b=0;
    %a=4/n/pi;b=0;
    %a=4/pi/n;b=0;
else     % even n
   % if mod(n/2,2)==1%4k+2
    %    a=8/n/pi;b=0;
    %else
     %   a=0; b=0;
    %end
   %a=0;b=0;
   a=0; b=-4/pi/(n^2-1);
end

end
