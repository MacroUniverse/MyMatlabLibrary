
N=60; %粒子数
q=30;%能量子数
Nlevel=q+1; %能级数

AllDis=zeros(50,Nlevel); %每一行就是一种独一无二的粒子数分布(Distribution)
Dis=zeros(1,Nlevel); Dis(1)=N;%当前的粒子数分布, 初始化是所有粒子集中在能级0.
levels=0:Nlevel-1;
Ndone=0; %已完成的分布个数
p=1; %等待减少的格子(能级)的序号(指针pointer).
while 1 %循环1开始
    if p<1
        break; %如果指针指到零, 左移直到非零. 
    elseif Dis(p)==0
        while p>0 && Dis(p)==0
            p=p-1; 
        end
        if p<1, break; end
    end

    Dis(p)=Dis(p)-1; Dis(p+1:end)=0; %指针处减小1, 后面的格子全部清零
    Nleft=N-sum(Dis(1:p)); %所剩粒子数
    if Nleft>1 %如果粒子数大于1, 把剩下的粒子放在右边一格, 同时移动指针到该格. 
        p=p+1; Dis(p)=Nleft;
    else %如果粒子还剩1, 把剩下的一个粒子正确放置, 指针从正确放置左移两位(如果指针非法, 跳出循环1), 储存分布, 重新开始循环1.
        Eleft=q-Dis*levels'; %计算剩下的能量(效率低)
        Dis(Eleft+1)=1; AllDis(Ndone+1,:)=Dis; Ndone=Ndone+1; p=Eleft-1;
        continue;
    end

    E=Dis*levels'; %计算当前分布的能量(效率低)
    if E<q %如果能量结果是小于
        if Dis(p)>2, continue; %如果最后一位大于2, 重新开始循环2.
        elseif Dis(p)==2 %如果最后一位等于2, 生成若干”1,1组合”.
            Dis(p)=0;
            temp=p+q-E; %第2个1的格子数
            for pair11=1:floor((q-E)/2) %共有ceil((q-E)/2)个11组合
                AllDis(Ndone+1,:)=Dis; AllDis(Ndone+1,[p,temp])=1;
                Ndone=Ndone+1; p=p+1; temp=temp-1;
            end
            if mod(q-E+1,2)==1 %最后一个11对是2.
                AllDis(Ndone+1,:)=Dis;
                AllDis(Ndone+1,p)=2; Ndone=Ndone+1; p=p-2; continue;
            else %最后一个11对是11.
                AllDis(Ndone+1,:)=Dis; AllDis(Ndone+1,[p, temp])=1; Ndone=Ndone+1;
                p=p-1; continue; %跳出循环2, 重新开始循环1
            end
        end

    elseif E>q
        p=p-2; if p<0, break; end %跳出循环1
    else %E=q
        p=p-2; AllDis(Ndone+1,:)=Dis; Ndone=Ndone+1; if p<0, break; end %跳出循环1
    end
end

%if Ndone>50, warning('AllDis too small'); end
AllDis=AllDis(1:Ndone,:);
hold on; plot(mean(AllDis),'+-');
