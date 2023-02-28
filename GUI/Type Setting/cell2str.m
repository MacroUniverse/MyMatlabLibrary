%Convert Cell matrix containing only class 'char', separated by char(13)
%If input 'separator', then will be seperated by 'separator'

function String=cell2str(Cell)
if ndims(Cell)==1
    String=OneDimCell(Cell);
elseif ismatrix(Cell)
    String=MatrixCell(Cell);
else
    error('input is at most 2-dimensional');
end
end

function String=OneDimCell(Cell,separator)
if nargin==1, separator=char(13); end
total=0;% total number of characters

N=numel(Cell);
Nc=zeros(N,1);
for ii=1:N
    Nc(ii)=numel(Cell{ii});
    total=total+Nc(ii)+1;
end
String=char(zeros(1,total));
pointer=1;
for ii=1:N
    String(pointer:pointer+Nc(ii))=[Cell{ii} separator];
    pointer=pointer+Nc(ii)+1;
end
end


% Matrix Display
% Left alignment of column

function String1=MatrixCell(Cell)

space=3;
[M,N]=size(Cell);
% 1. Get the length of longest string in one cell, 'Lmax'
Lmax=zeros(1,N);
for n=1:N
for m=1:M
    L=numel(Cell{m,n});
    if Lmax(n)<L, Lmax(n)=L; end
end
end

Lrow=sum(Lmax)+space*(N-1);
String=char(32*ones(M,Lrow));
for m=1:M
for n=1:N
    string=Cell{m,n};
    ind=sum(Lmax(1:n-1))+(n-1)*space +1;
    String(m,ind:ind+numel(string)-1)=string;
end
end
String1=char(32*ones(1,Lrow*N+M));
for m=1:M
    ind=(Lrow+1)*(m-1)+1;
    String1(ind:ind+Lrow)=[String(m,:) char(13)];
end
String1=String1(1:end-1);
end