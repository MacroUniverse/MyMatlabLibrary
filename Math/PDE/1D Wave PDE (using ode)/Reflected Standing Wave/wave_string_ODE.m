
%理想若干质点弹簧线ODE文件
%理想若干质点弹簧线ODE文件
%输入：n个振子的位移及速度共2n个变量
%输出：上述变量对时间的导数共2n个变量
%varagin: 1.k; 2.m; 3.波源发生函数'f_S0_t'; 4.积分区间tspan；
%             5.初值； 
function varargout=wave_string_ODE(t,SV,flag,varargin)

switch flag
    case''
        [varargout{1}]=f(t,SV,varargin{:});
    case'init'
        [varargout{1:3}]=init(varargin{:});
    otherwise
        error(['Unknown flag ''' flag '''.']);
end

end

%以下是odefile.m的子函数，他们分别与“父”函数中各情况相对应。
%--------------------------------------------------------------------------
function dydt = f(t,SV,varargin)
LEN=length(SV);
k=varargin{1};%弹性系数
m=varargin{2};%振子质量
S0=eval(varargin{3});%波源振子函数

S=SV(1:LEN/2);%位移变量
v=SV((LEN/2+1):LEN);%速度变量
a=A(k,m,S0,S);%求加速度


dydt=zeros(size(SV));
dydt(:)=[v(:),a(:)];
end

%--------------------------------------------------------------------------
function [tspan,y0,options]=init(varargin)
tspan =varargin{4};
y0=varargin{5};
options=[];
end

%-------------------------------------------------------------------------- 
%function f 中的a的具体计算
function a=A(k,m,S0,S)%已调试成功

dS=diff(S);%前后振子的位移差
d2S=diff(dS);%中间每个振子与前后振子的位移差之差

a_middle=k*d2S/m;%中间振子的加速度
a1=k*(dS(1)-(S(1)-S0))/m; %第一个振子的加速度
a_end=k*(0-S(end)-dS(end))/m;%最后一个振子的加速度
a=[a1;a_middle;a_end];%全部的加速度；
end