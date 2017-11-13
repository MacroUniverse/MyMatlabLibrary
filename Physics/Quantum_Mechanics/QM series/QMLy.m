%find the Ly matrix in the Lz bases
%natural unit (h1=1)

function Lz=QMLy(l)
N=2*l+1;
m=l:-1:-l;
temp=l*(l+1);
SubDiag=sqrt(temp-m.*(m-1));
Lz=zeros(N,N);
for ii=1:N-1
    Lz(ii,ii+1)=SubDiag(ii)/(2i);
    Lz(ii+1,ii)=-SubDiag(ii)/(2i);
end

end