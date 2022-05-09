% lagr_solve_demo
function lagr_solve_demo
% ==== 参数 =====
m1 = 1; m2 = 1; g = 9.8;
l1 = 1; l2 = 1;
tmin = 0; tmax = 10; Nt = 200;
qq0 = [pi, pi, -4, 6];
RelTol = 1e-6;
L = @(qqt)L_fun(qqt, m1, l1, m2, l2, g);
% ==============
close all;
t = linspace(tmin, tmax, Nt);
qq = lagr_solve(L, qq0, t, RelTol);

th1 = qq(:,1); th2 = qq(:,2);
x1 = l1*sin(th1); y1 = -l1*cos(th1);
x2 = x1 + l2*sin(th2); y2 = y1 - l2*cos(th2);
figure;
% 动画
for it = 1:Nt
    clf;
    plot([0, x1(it)], [0, y1(it)], 'k'); hold on;
    scatter(x1(it), y1(it), 'k');
    plot([x1(it), x2(it)], [y1(it), y2(it)], 'k');
    scatter(x2(it), y2(it), 'k');
    plot(x2(1:it), y2(1:it));
    axis equal; axis([-1,1,-1,1]*(l1+l2)*1.1);
    title(['t = ' num2str(t(it), '%.2f')]);
    xlabel x; ylabel y;
    pause(0.1); % saveas(gcf, [num2str(it) '.png']);
end
end

% 双摆
function ret = L_fun(qqt, m1, l1, m2, l2, g)
th1 = qqt(1); th2 = qqt(2);
w1 = qqt(3); w2 = qqt(4);
T = 0.5*m1*(l1*w1)^2 + 0.5*m2*((l1*w1*cos(th1) + l2*w2*cos(th2))^2 ...
    + (l1*w1*sin(th1) + l2*w2*sin(th2))^2);
V = -m1*g*l1*cos(th1) - m2*g*(l1*cos(th1) + l2*cos(th2));
ret = T - V;
end
