% 数值解拉格朗日方程
% 拉格朗日量 L(qqt), qqt = [q, dq, t]
% 一阶偏微分 dL(i,qqt), 可选, 若不支持 i > N， 返回 nan
% 二阶偏微分 d2L(i,j,qqt) 可选, i = N+1:2*N, j = 1:2*N+1
% 广义力 Q(i, qqt) 可选
function qq = lagr_solve(L, qq0, t, RelTol, dL, d2L, Q, vpa_flag)
%====== 参数设置 =======
h = 1e-5; % 1 阶差分长度
h2 = 1e-5; % 2 阶差分长度
%=====================
N = numel(qq0)/2;
if ~exist('vpa_flag', 'var') || isempty(vpa_flag)
    vpa_flag = false;
end
if ~exist('d2L', 'var') || isempty(d2L)
    if ~exist('dL', 'var') || isempty(dL) || isnan(dL(N+1,[qq0, tmin]))
        if vpa_flag
            d2L = @(i,j,qqt)D2_ij_vpa(L,i,j,qqt,h2);
        else
            d2L = @(i,j,qqt)D2_ij(L,i,j,qqt,h2);
        end
    else
        d2L = @(i,j,qqt)d2L_dif1(dL,i,j,qqt,h);
    end
end
if ~exist('dL', 'var') || isempty(dL)
    if vpa_flag
        dL = @(i, qqt)D_i_vpa(L, i, qqt, h);
    else
        dL = @(i, qqt)D_i(L, i, qqt, h);
    end
end
if ~exist('Q', 'var') || isempty(Q)
    Q = @(i,qqt) 0;
end
options = odeset('RelTol', RelTol);
[T, QQ] = ode45(@(t,qq)ode_fun(t, qq, dL, d2L, Q), ...
        [t(1), t(end)], qq0, options);
qq = zeros(numel(t), 2*N);
for i = 1:2*N
    qq(:,i) = interp1(T, QQ(:,i), t, 'spline');
end
end

function dqq = ode_fun(t, qq, dL, d2L, Q)
N = numel(qq)/2;
dqq = zeros(2*N, 1);
dqq(1:N) = qq(N+1:end);
qqt = [qq; t];
A = zeros(N, N); % A_ij = d2L/d(\dot q_i)d(\dot q_j)
for i = 1:N
    for j = i:N
        A(i,j) = d2L(i+N, j+N, qqt);
        if i ~= j
            A(j,i) = A(i,j);
        end
    end
end
b = zeros(N, 1);
for i = 1:N
    b(i) = dL(i, qqt) - d2L(i+N,2*N+1,qqt) + Q(i,qqt);
    for j = 1:N
        b(i) = b(i) - d2L(N+i,j,qqt)*qqt(j+N);
    end
end
dqq(N+1:end) = A \ b;
if any(isnan(dqq) | isinf(dqq))
    error('wrong!');
end
end

% d^2 L / d(qqt_i)d(qqt_j)
% dL is dL/d(qqt_i)
function ret = d2L_dif1(dL, i, j, qqt, h)
qqt(j) = qqt(j) - 0.5*h;
L1 = dL(i, qqt, h);
h = (qqt(j) + h) - qqt(j);
qqt(j) = qqt(j) + h;
L2 = dL(i, qqt, h);
ret = (L2 - L1) / h;
end
