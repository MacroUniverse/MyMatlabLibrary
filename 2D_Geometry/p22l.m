%平面两点决定平面射线
%size(p1)=size(p2)=[N,2]; size(l)=[N,3];
function l=p22l(p1,p2)
N=size(p1,1);
l=zeros(N,3);
l(:,[1 2])=p1;
l(:,3)=atan2(p2(:,2)-p1(:,2),p2(:,1)-p1(:,1)); %决定角度.
end