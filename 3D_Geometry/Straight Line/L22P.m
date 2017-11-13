%通过两个L,求出它们近似交点R,两射线h以及对应的t1,t2,用于误差分析
%size(L)=(N,6)
%程序中的c是cos<e1,e2>
%公式利用对比系数原理求出


function [P,h,t1,t2]=L22P(L1,L2)
N=size(L1,1);
if N==1

   P1=L1(1:3);
   P2=L2(1:3);
   e1=L1(4:6);
   e2=L2(4:6);

   m=dot((P2-P1),e1);
   n=dot((P2-P1),e2);
   c=dot(e1,e2);
   s2=1-c^2;
   t1=(m-n*c)/s2;
   t2=(m*c-n)/s2; 
   h=distL2P2(L1,L2,t1,t2);
   
   R1=LR2P(L1,t1);
   R2=LR2P(L2,t2);
   P=(R1+R2)/2;
elseif N>1
   if size(L1)~=size(L2)
   error('L1,L2 size not match');
   end

   P1=L1(:,1:3);
   P2=L2(:,1:3);
   e1=L1(:,4:6);
   e2=L2(:,4:6);
   
   m=dot((P2-P1)',e1')';
   n=dot((P2-P1)',e2')';
   
   c=dot(e1',e2')';
   s2=1-c.^2;
   t1=(m-n.*c)./s2;
   t2=(m.*c-n)./s2; 
   h=distL2P2(L1,L2,t1,t2);
   
   R1=LR2P(L1,t1);
   R2=LR2P(L2,t2);
   P=(R1+R2)/2;
    

end

end
