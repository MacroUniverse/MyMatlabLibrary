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