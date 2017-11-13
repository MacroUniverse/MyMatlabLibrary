%点到空间直线(6参数)的距离
%size(P)=[N,3]或者[1,3]; 
%size(L)=[N,6];

function H=LP2H(L,P)

NL=size(L,1); NP=size(P,1);
if (NL~=NP)&&(NP==1)
    P=repmat(P,NP,1);
end

e=L(:,4:6);
dP=P-L(:,1:3);
H=vmag(cross(dP',e'));

end