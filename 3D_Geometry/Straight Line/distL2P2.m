%两条空间直线上的点的距离
%L1L2满足size=(N,6) t1t2满足size=(N,1)

function    dist=distL2P2(L1,L2,t1,t2)

R1=LR2P(L1,t1);
R2=LR2P(L2,t2);
dist=vmag(R1-R2);

end