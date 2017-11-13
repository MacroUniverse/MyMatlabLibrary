%Calculate the CG-coefficient Matrix
% m1 must be specified as a vector
% CGMatrix has |m1>|m2> as input and |J,M> as output.
% m1 is in the order specified, J is in descending order.
% This function is verified to work the same as in Griffiths book.

function [CGMatrix,J,J2]=QMCG(l1,l2,M)
% non-degenerate case
if abs(M) == l1+l2
    CGMatrix = 1; J2 = 1; J = l1+l2; return;
end

% dimension of J2 matrix
if abs(M)>=abs(l1-l2)
    N = l1+l2+1-abs(M);
else
    N = min(2*l1+1,2*l2+1);
end

% maximum values of m1
if M>=l1-l2
    m1_max = l1;
else
    m1_max = l2+M;
end
m1_list = m1_max:-1:m1_max+1-N;

J2 = zeros(N);
L1_2 = l1*(l1+1); L2_2 = l2*(l2+1); % L1^2 eigen value

% J^2 matrix, 2:N-1 column
% J^2 matrix is tridiagonal in M space
for ii = 2:N-1
    m1 = m1_list(ii); m2 = M-m1;
    J2(ii,ii) = L1_2 + L2_2 + 2*m1*m2;
    J2(ii-1,ii) = sqrt((L1_2-m1*(m1+1))*(L2_2-m2*(m2-1)));
    J2(ii+1,ii) = sqrt((L1_2-m1*(m1-1))*(L2_2-m2*(m2+1)));
end
% J^2 matrix, 1st and last column
m1 = m1_list(1); m2 = M-m1;
J2(1,1) = L1_2 + L2_2 + 2*m1*m2;
J2(2,1) = sqrt((L1_2-m1*(m1-1))*(L2_2-m2*(m2+1)));
m1 = m1_list(N); m2 = M-m1;
J2(N,N) = L1_2 + L2_2 + 2*m1*m2;
J2(N-1,N) = sqrt((L1_2-m1*(m1+1))*(L2_2-m2*(m2-1)));

[CGMatrix,J] = Eig(J2);  J = diag(J); 
J = (sqrt(1+4*J)-1)/2; % convert from eigen value to quantum number
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
for ii = 1:size(V,2)
    V(:,ii) = V(:,ii)*sign(V(1,ii));
end
end
