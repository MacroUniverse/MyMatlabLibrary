% NelderMead() 函数的变精度计算版
% f 是函数句柄，只接受一个 N 维行矢量作为输入变量， 并返回一个函数值
% x0 是 N 维行矢量， xerr 是 xmin 各个元素的绝对误差
function [xmin, fmin] = NelderMead_sym(f, x0, xerr)
N = numel(x0); % f 是 N 元函数
x = vpa(zeros(N+1,N)); % 预赋值
y = vpa(zeros(1,N+1));
% 计算 N+1 个初始点
x(1,:) = x0;
for ii = 1:N
    x(ii+1,:) = x(1,:);
    if x(1,ii) == 0
        x(ii+1,ii) = 0.00025;
    else
        x(ii+1,ii) = 1.05 * x(1,ii);
    end
end
% 主循环
x_last = x + eps;
mask = true(1, N+1); % 改变的顶点
while true
    if max(max(abs(x(2:end,:) - x(1,:)))) < xerr % 判断误差
        break;
    elseif all(x(:) == x_last(:))
        warning('NelderMead: abs err too small, machine precision reached');
        break;
    else
        x_last = x;
    end
    % 求值并排序
    parfor ii = find(mask)
        y(ii) = f(x(ii,:));
        mask(ii) = false;
    end
    [y, order] = sort(y);
    x = x(order,:);
    mask = mask(order);
    m = mean(x(1:N,:)); % 平均位置
    r = 2*m - x(N+1,:); % 反射点
    f_r = f(r);
    mask(end) = true;
    if y(1) <= f_r && f_r < y(N) % 第 4 步
        x(N+1,:) = r; continue;
    elseif f_r < y(1) % 第 5 步
        s = m + 2*(m - x(N+1,:));
        if f(s) < f_r
            x(N+1,:) = s;
        else
            x(N+1,:) = r;
        end
        continue;
    elseif f_r < y(N+1) % 第 6 步
        c1 = m + (r - m)*0.5;
        if f(c1) < f_r
            x(N+1,:) = c1; continue;
        end
    else % 第 7 步
        c2 = m + (x(N+1,:) - m)*0.5;
        if f(c2) < y(N+1)
            x(N+1,:) = c2; continue;
        end
    end
    for jj = 2:N+1 % 第 8 步
        x(jj,:) = x(1,:) + (x(jj,:) - x(1,:))*0.5;
        mask(jj) = true;
    end
end
% 输出变量
xmin = x(1,:);
fmin = f(xmin);
end
