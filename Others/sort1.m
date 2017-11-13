% sort and delete repeated values

function [num,order]=sort1(num,varargin)
[num,order]=sort(num,varargin{:});
Ind=repeated(num);
num(Ind)=[]; order(Ind)=[];
end

function Ind=repeated(numbers)
%find degeneracy, start from numbers(ind(kk)) to numbers(ind(kk)+count(kk))
Nd=numel(numbers);
ind=zeros(Nd,1); count=ind; kk=1;
for ii=2:Nd
    if numbers(ii)==numbers(ii-1)
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

Ind=zeros(1,sum(count));
kk=1;
for ii=1:numel(ind)
    Ind(kk:kk+count(ii)-1)=ind(ii)+1:ind(ii)+count(ii);
    kk=kk+count(ii);
end
end