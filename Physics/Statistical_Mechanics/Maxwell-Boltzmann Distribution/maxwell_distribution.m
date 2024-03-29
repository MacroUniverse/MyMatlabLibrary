%麦克斯韦-波尔兹曼分布

% === 参数设置 ====
N = 100; % 总粒子数
m = 1e-3; % 粒子质量
R = 1e-3; % 粒子半径

% 容器规格
Size = [1,1,1];% [x长度, y长度, z长度].0<x<x长度, y...,z....
tmax = 10; Nt = 1000; % 模拟总时间
T = 10; % 温度
kb = 1.380650324; % 波尔兹曼常量

% 每个粒子的位置矢量
for i = 3:-1:1
    P(:,i) = rand(N,1)*Size(i);
end
% 每个粒子的速度矢量
V = rand(N,3);
V = vunit(V)*sqrt(3*kb*T/m); % 每个粒子都要有平均动能
v = vmag(V); % 速度绝对值

t = linspace(0, tmax, Nt);

