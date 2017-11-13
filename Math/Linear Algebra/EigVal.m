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