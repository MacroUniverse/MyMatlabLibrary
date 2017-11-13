%Find the common eigen vectors and eigen values for commutable Hermitian
%Matirces A and B
function [V,DA,DB]=CommonEig(A,B)

[VA, DA]=Eig(A);
ValA=diag(DA);
Nd=size(A,1);
[ind,count]=repeated(ValA);
V=zeros(Nd); kk=1; ValB=zeros(Nd,1); ii=1;
while ii<=Nd
    if ii<ind(kk) % nondegeneracy
        V(:,ii)=VA(:,ii); ValB(ii)=EigVal(B,VA(:,ii));
        ii=ii+1;
    else % ii==ind(kk)
        temp=ind(kk):ind(kk)+count(kk);
        basis=VA(:,temp);
        [VB_A,DB]=Eig(basis'*B*basis);
        V(:,temp)=basis*VB_A; ValB(temp)=diag(DB);
        ii=ii+count(kk)+1; kk=kk+1;
    end
end
DB=diag(ValB);
end

% support single A and multiple V
function Val=EigVal(A,V)
Nd=size(A,1); Nv=size(V,2);
Val=nan(Nv,1);
for jj=1:Nv
    for ii=1:Nd
        temp=A(ii,:)*V(:,jj)./V(ii,jj);
        if abs(V(ii,jj))>1e-10
            
            if ~isnan(Val(jj)) 
                if abs(temp-Val(jj))>1e-10
                    error('not an eigen vector!');
                end
            else
                Val(jj)=temp;
            end
        end
    end
end
end

function [ind,count]=repeated(numbers)
%find degeneracy, start from numbers(ind(kk)) to numbers(ind(kk)+count(kk))
Nd=numel(numbers);
ind=zeros(Nd,1); count=ind; kk=1;
for ii=2:Nd
    if abs(numbers(ii)-numbers(ii-1))<1e-10
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

end


