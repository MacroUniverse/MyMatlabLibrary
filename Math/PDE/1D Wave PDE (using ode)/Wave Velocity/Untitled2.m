%该脚本为了验证Vn=sqrt(k/m)

load('num_num','num_num')
%先定义num_num的规格（n,3）
plot(yy(2000,1:300));grid on;%需调整图像大小
[xxx,~]=ginput(2);%取m个波
m=[]%请先在这里修改m
xxx=diff(xxx)/m;
num_num(11,:)=[60,xxx];%需修改实验数据

save('num_num', 'num_num')

%把以上步骤重复若干次，执行
num_num2=num_num*f;%f是主程序中波源的频率
plot(1:0.1:60,sqrt(1:0.1:60),num_num2(:,1),num_num2(:,3),'r.')

%若红点都基本落在蓝线上，就说明Vn=sqrt(k/m)是正确的
