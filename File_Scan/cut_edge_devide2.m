%二分法, 在扭曲图像的右边界选取一个点C
%使线段(AB)与线段(BC)尽量垂直

function indC=cut_edge_devide2(bound, indA, indB, ind3, ind4)

indL=ind3; indR=ind4;
signL=sign(f(bound, indA, indB, ind3));
signR=sign(f(bound, indA, indB, ind4));

if signL==0%解在左端点
    indC=indL; return
elseif signR==0%解在右端点
    indC=indR; return
elseif signL==signR%无解
    indC=nan; return
end

while indR-indL>1 
    indC=round((indL+indR)/2);
    cosine=f(bound, indA, indB, indC); %函数在这里修改
    Sign=sign(cosine);
    if Sign==signL
        indL=indC;
    elseif Sign==signR
        indR=indC;
    elseif Sign==0
        return
    end
end

if indL<indR
    if sign(f(bound, indA, indB, indL))==signL
        indC=indL;
    else
        indC=indR;
    end
end

end

function cosine=f(bound, indA, indB, indC)
cosine=vunit(bound(indB,:)-bound(indA,:))*vunit(bound(indC,:)-bound(indB,:))';
end
