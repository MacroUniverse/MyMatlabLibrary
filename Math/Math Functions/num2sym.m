% convert numbers to symbolic expression of the form A*sqrt(B)/C
% Actually, just put in the number into Wolfram Alpha will work much
% better.
% A,B,C are integers

% Sym is a cell array that contains class 'char'
% Num is any matrix
% max_int is the largest integer numbers A,B,C can be
% RelErr is the relative err for comparing two numbers.


function Sym=num2sym(Num,max_int,RelErr)

if nargin==1
    max_int=100; RelErr=0.0001;
end

Sym=cell(size(Num));
A=zeros(1,max_int^3); B=A; C=A; compare=A; mark=true(size(A));

Sign=sign(Num); Num=abs(Num);

% match the form of a*sqrt(b)/c
% For each loop, I could have used bisection method to improve speed.

%_______________________Construct numbers to be compared
ii=1;
for a=1:max_int
for b=1:max_int
for c=1:max_int
    A(ii)=a; B(ii)=b; C(ii)=c;
    compare(ii)=a*sqrt(b)/ c;
    ii=ii+1;
end
end
end

[compare,order]=sort(compare,'ascend'); A=A(order); B=B(order); C=C(order);
[ind,count]=repeated(compare);
for ii=1:numel(ind)
    range=ind(ii):ind(ii)+count(ii);
    mark(range)=false;
    [~,Indmin]=min(B(range));
    mark(ind(ii)-1+Indmin)=true;
end
%__________________________Now compare
compare=compare(mark); A=A(mark); B=B(mark); C=C(mark);


for ii=1:numel(Num)
    
    if abs(Num(ii))< RelErr
        Sym{ii}='0'; continue;
    end
    [err,ind]=min(abs(compare-Num(ii)));
    if err/Num(ii)<=RelErr
        string='';
        if compare(ind)==1
            if Sign(ii)==-1
                Sym{ii}='-1'; continue;
            else
                Sym{ii}='1'; continue;
            end
        end
        if Sign(ii)==-1
            string=[string '-'];
        end
        if A(ind)>1
            if B(ind)>1
                string=[string num2str(A(ind)) '*sqrt(' num2str(B(ind)) ')'];
            else
                string=[string num2str(A(ind))];
            end
        else %  A(ind)==1
            if B(ind)>1
                string=[string 'sqrt(' num2str(B(ind)) ')'];
            else % B(ind)==1
                string=[string '1'];
            end
        end
        if C(ind)>1
            string=[string '/' num2str(C(ind))];
        end
        Sym{ii}=string;
    else
        error('use larger ''RelErr'' or larger ''max_int''')
    end
end

Sym=cell2str(Sym);
warning('Please check manually for correctness');
end


% If nargout==1
% Ind is the index of numbers elements that's repeated 
%(not including the first one)

% If nargout==2
% Ind is the index of the numbers followed by repeating numbers
% count(ii) is the number of the repeated number following numbers(ind(ii))

% If nargout==3
% Ind is the index of numbers elements that's repeated (not including the first one)
% ind is the index of the numbers followed by repeating numbers

function [Ind,count,ind]=repeated(numbers)
%find degeneracy, start from numbers(ind(kk)) to numbers(ind(kk)+count(kk))
Nd=numel(numbers);
ind=zeros(Nd,1); count=ind; kk=1;
for ii=2:Nd
    if abs(numbers(ii)-numbers(ii-1)) < eps
        if count(kk)==0, ind(kk)=ii-1; end
        count(kk)=count(kk)+1;
    elseif count(kk)>0
        kk=kk+1;
    end 
end

if count(kk)>0
    ind=ind(1:kk); count=count(1:kk);
else
    ind=ind(1:kk-1); count=count(1:kk-1);
end

if nargout==2
    Ind=ind;
elseif nargout==1 || nargout==3
        Ind=zeros(1,sum(count));
    kk=1;
    for ii=1:numel(ind)
        Ind(kk:kk+count(ii)-1)=ind(ii)+1:ind(ii)+count(ii);
        kk=kk+count(ii);
    end
end
end


% Convert Cell matrix containing only class 'char', separated by char(13)
% If input 'separator', then will be seperated by 'separator'

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