%数值解pmd程序
%已知三个空间点的坐标P1,P2,P3, 以及顶角ang12, ang23, ang31. 求顶点可能的所有位置
%pmd0

function P=numpmd(pmd0)
[int,N]=pmd_mono_domains(pmd0);
NN=numel(N);
L1=zeros(NN,1);
for ii=1:NN
    path=pmdPath(N(ii));
    L1(ii)=devide2(int(ii,:),1e-5,pmd0,path);
end

mark=isnan(L1);
L1(mark)=[];
N(mark)=[];

P1=pmd0(1,:); P2=pmd0(2,:); P3=pmd0(3,:);
L12=vmag(P1-P2); 
L23=vmag(P2-P3);
ang12=pmd0(4,1); ang23=pmd0(4,2);

NP=numel(L1);
P=zeros(NP,3);
for ii=1:NP
    path=pmdPath(N(ii));
    L2=bbj(L12,L1(ii),ang12,path(1));
    L3=bbj(L23,L2,ang23,path(2));
    P(ii,:)=pmdL32P(L1(ii),L2,L3,P1,P2,P3);
end

end