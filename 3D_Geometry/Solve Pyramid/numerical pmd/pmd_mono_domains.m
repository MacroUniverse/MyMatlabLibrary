%从格式inte中寻找1个单解域,函数在文件中修改

%思路:边边角有两个解, 较大的解可分为一个单增区间和一个单减区间
%较小的解单调递减, 所以, 每次传递分为三个区间, 由于单调函数叠加还是单调函数
%于是理论上可以找到3^3=27个单调区间, 于是该函数计算27个区间

%D是定义域的三个区间, R是值域的三个区间. 分别按照以上的描述排列. 所以每一次的
%正向传递路径为[ 1 1 2](1代表较大的解), 增减性为[+ - +];


function  [int, path]=pmd_mono_domains(pmd0)

%解压pmd0
P1=pmd0(1,:); P2=pmd0(2,:); P3=pmd0(3,:);
L12=vmag(P2-P1); L23=vmag(P3-P2); L31=vmag(P1-P3);
ang12=pmd0(4,1); ang23=pmd0(4,2); ang31=pmd0(4,3);

%每两根棱之间的定义域和值域
Ls12=L12/sin(ang12); Lt12=L12/tan(ang12);
Ls23=L23/sin(ang23); Lt23=L23/tan(ang23);
Ls31=L31/sin(ang31); Lt31=L31/tan(ang31);

R12=[L12 Ls12; Lt12 Ls12; 0 Lt12]; 
R23=[L23 Ls23; Lt23 Ls23; 0 Lt23];
D31=[0 Lt31; Lt31 Ls31; L31 Ls31];


%%
%L3上的定义域 (int3=D31)
Int3=zeros(9,2);
kk=1;
for ii=1:3
    for jj=1:3
        Int3(kk,:)=intersection(R23(ii,:),D31(jj,:));
        kk=kk+1;
    end
end

%%
%L3-L2区间传递
int2=zeros(4,2);
temp1=[L23 L23]; temp2=[ang23 ang23];
for ii=1:3
    int2(ii,:)=bbj(temp1, Int3(ii,:),temp2,2);
end
for ii=4:6
    int2(ii,:)=bbj(temp1, Int3(ii,[2 1]) ,temp2,1);
end
for ii=7:9
    int2(ii,:)=bbj(temp1, Int3(ii,:),temp2,1);
end

%%
%L2上的定义域
kk=1;
Int2=zeros(27,2);  
for ii=1:3
    for jj=1:9
        Int2(kk,:)=intersection(R12(ii,:),int2(jj,:));
        kk=kk+1;
    end
end


%%
%L2-L1区间的传递
int=zeros(27,2);
temp1=[L12 L12]; temp2=[ang12 ang12];
for ii=1:9
    int(ii,:)=bbj(temp1, Int2(ii,:), temp2,2);
end
for ii=10:18
   int(ii,:)=bbj(temp1, Int2(ii,[2 1]), temp2,1);
end
for ii=19:27
   int(ii,:)=bbj(temp1, Int2(ii,:),temp2,1);
end


%%
%编号, 排序
mark=~isnan(int(:,1));
int=int(mark,:);
path=find(mark);

end