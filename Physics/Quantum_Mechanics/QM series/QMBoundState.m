% 势能是对称的C1*f1+C2*f2是[0,a]区间的通解, C3*g是区间
% f1(x,E);f2(x,E);g(x,E)都是以能量为参数的波函数, 
% a是边界
function [E,C]=QMBoundState(f1,f2,a,g,E_range,E_resolution)

% 找到奇函数的能级分布
Eodd=fzeroN( @(E) Det(E,f1,f2,a,g,'odd'), E_range, E_resolution);
% 找到奇函数的能级分布
Eeven=fzeroN( @(E) Det(E,f1,f2,a,g,'even'), E_range, E_resolution);

%把所有能级和系数整理到一起
%第一个能级是偶函数, 然后依次奇偶交错
NE=numel(Eodd)+numel(Eeven);
E=zeros(NE,1);
C=zeros(NE,3);
for ii=1:(numel(Eodd)+numel(Eeven))
    if mod(ii,2)==1 %偶函数
        E(ii)=Eeven((ii+1)/2);
        [~,Mat]=Det(E(ii),f1,f2,a,g,'even');
        C(ii,:)=null(Mat([1 2],:))';
    else
        E(ii)=Eodd(ii/2);
        [~,Mat]=Det(E(ii),f1,f2,a,g,'odd');
        C(ii,:)=null(Mat([1 2],:))';
    end
end

% 画波函数
Nplot=300;

for ii=1:NE
    FunCell={@(x) C(ii,1)*f1(x,E(ii))+ C(ii,2)*f2(x,E(ii)),...
             @(x) C(ii,3)*g(x,E(ii))};
    if mod(ii,2)==1, temp='even'; else temp='odd'; end
    plotPW(Nplot,FunCell,[0 a 3*a],temp,'r')
    title(['Wave Function for Energy Level ' num2str(ii)]);
end
end

function [D,Mat]=Det(E,f1,f2,a,g,odd_even)
h=1e-7;
f1=@(x) f1(x,E); f2=@(x) f2(x,E); g=@(x) g(x,E);
f1_=@(x) (f1(x+h)-f1(x-h))/(2*h);
f2_=@(x) (f2(x+h)-f2(x-h))/(2*h);
g_=@(x) (g(x+h)-g(x-h))/(2*h);

if odd_even(1)=='o'
   Mat=[f1(0)  f2(0)   0            % 奇函数 phi(0)=0
        f1(a)  f2(a)   -g(a)        % a处连续
        f1_(a) f2_(a)  -g_(a)];     % a处光滑
else
   Mat=[f1_(0) f2_(0)   0           % 偶函数 phi(0)'=0
        f1(a)  f2(a)   -g(a)        % a处连续
        f1_(a) f2_(a)  -g_(a)];     % a处光滑
end
D=det(Mat);

end