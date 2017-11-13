function Lz=QMLplus(l)
N=2*l+1;
m=l:-1:-l;
temp=l*(l+1);
SubDiag=sqrt(temp-m.*(m-1));
Lz=zeros(N,N);
for ii=1:N-1
    Lz(ii,ii+1)=SubDiag(ii);
end

end