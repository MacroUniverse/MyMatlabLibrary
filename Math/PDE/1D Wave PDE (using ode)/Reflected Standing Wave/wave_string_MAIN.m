 %理想若干质点弹簧线MAIN文件
 %理想若干质点弹簧线MAIN文件
 k=1;
 m=1;
 f_S0_t='sin((1/40)*(2*pi)*t)';
 tspan=[0,900];
 SV0=zeros(1,600);
 
 VARS={k,m,f_S0_t,tspan,SV0};
[t,yy]=ode45('wave_string_ODE',[],[],[],VARS{:});

plot(t(1:41)',yy(1:41,41:45))
title('\fontname{隶书}\fontsize{20}第41到45个振子由行波变为驻波的''位移-时间''图')

