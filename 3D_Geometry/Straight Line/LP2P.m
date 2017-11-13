%找到L上距离点P最近的一点
%size(L)=[N,6];
%size(P)=[N,3]或者[1,3];


function [P,R]=LP2P(L,P)

NL=size(L,1); NP=size(P,1);

if (NP~=NL)&&(NP==1)
    P=repmat(P,NL,1);
end


R=dot((P-L(:,1:3))',L(:,4:6)');
P=LR2P(L,R);

end