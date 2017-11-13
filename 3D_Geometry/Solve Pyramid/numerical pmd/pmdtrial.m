%由L1算指定路径的L=[L1 L2 L3 L4];
%无解以nan填充

%输入三棱锥的第一条边, 以及传递路径, 得出回到第一条边的长度y. 如果y=L1, 那么L1就是三棱锥的一条棱

function [y, L123]=pmdtrial(pmd0,L1,path)

%还原pmd数据
L12=vmag(pmd0(1,:)-pmd0(2,:));
L23=vmag(pmd0(2,:)-pmd0(3,:));
L31=vmag(pmd0(3,:)-pmd0(1,:));
ang12=pmd0(4,1);
ang23=pmd0(4,2);
ang31=pmd0(4,3);

L2=bbj(L12,L1,ang12,path(1));%一定会有解
L3=bbj(L23,L2,ang23,path(2));
L4=bbj(L31,L3,ang31,path(3));

y=L4-L1;
if nargout==2
    L123=[L1 L2 L3];
end
end