% Calculate the CG-coefficient Matrix

% Domain bases are |S^2,M>
% Range bases are all |l1,m1>|l2,m2> for which m1+m2=M
% To exchange Domain and Range, use Hermitian Conjugation to calculate the
                                                          %inverse matrix
% Using unit h1=1. (natural unit)
% L^2=L1^2+L2^2+L1x*L2x+L1y*L2y+L1z*L2z
% L^2|l1,m1>|l2,m2>=l1*(l1+1)+l2*(l2+1)+
%                   L1x|l1,m1>*L2x|l2,m2>
%                  +L1y|l1,m1>*L2y|l2,m2>
%                  +L1z|l1,m1>*L2z|l2,m2>

% for algorithm, see my YoudaoNote (QM series) and Physics Index
% This function is verified to work the same as in Griffiths book.

% need to output m1 value too!

function [CGMatrix,J]=QMCG0(l1,l2,M)
error('this is an older version of QMCG, use QMCG instead');
signM = sign(M); M = signM*M;
l2l1=0; % l2 already > l1.
if l2<l1 % l1>l2, need to revert in the end
    temp=l1; l1=l2; l2=temp;
    l2l1=1;
end 

L1x=QMLx(l1); L1y=QMLy(l1); L1z=QMLz(l1);
L2x=QMLx(l2); L2y=QMLy(l2); L2z=QMLz(l2);


%dimension of the L1L2 matrix (l2 must >=l1)
if abs(M)<l2-l1
    N=2*l1+1;
elseif M<=l1+l2
    N=-M+l1+l2+1;
else
    N=M+l1+l2+1;
end

% an N*N matrix cutted out from L1x and L1y matrix
if M==0
    Mat1x=L1x; Mat1y=L1y; Mat1z=L1z; 
elseif M>0
    Mat1x=L1x(1:N,1:N); Mat1y=L1y(1:N,1:N); Mat1z=L1z(1:N,1:N); 
end

% an N*N matrix cutted out from L2x and L2y matrix

range=l1+l2+2-N-M:l1+l2+1-M; % the range of possible m2
Mat2x=L2x(range,range); Mat2y=L2y(range,range); Mat2z=L2z(range,range);

% Matric of S^2 in the N |l1,m1>|l2,m2> bases.

W=2*Mat1x.*rot90(Mat2x,2)+2*Mat1y.*rot90(Mat2y,2)+2*Mat1z.*rot90(Mat2z,2)+eye(N)*(l1*(l1+1)+l2*(l2+1));

[CGMatrix,J]=Eig(W); J = diag(J);
J = (sqrt(1+4*J)-1)/2; % convert from eigen value to quantum number

% l1>l2, need to revert in the end
% signM<0, need to revert in the end
if (l2l1==1 && signM==1) || (l2l1~=1 && signM==-1)
    CGMatrix=flipud(CGMatrix);
end

% first element of eigen vector must be real
for ii = 1:size(CGMatrix,2)
    CGMatrix(:,ii) = CGMatrix(:,ii)*sign(CGMatrix(1,ii));
end
end

% a revision of function eig
% sort the eigen value matrix to descending order
% eigen vectors change order in the same way
% the first element of each eigen vector should be positive

function [V,D]=Eig(A)
[V,D]=eig(A);
a=diag(D);
[a,order]=sort(a,'descend');
D=diag(a);
V=V(:,order);
end
