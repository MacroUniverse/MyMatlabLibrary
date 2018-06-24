%二分法,函数与所需参数在程序中改
%闭区间中最多有一个解.
%无解返回nan

function x=devide2(int, err, pmd0, path)

xL=int(1); xR=int(2);
signL=sign(pmdtrial(pmd0,xL,path));
signR=sign(pmdtrial(pmd0,xR,path));

if signL==0%解在左端点
    x=xL; return
elseif signR==0%解在右端点
    x=xR; return
elseif signL==signR%无解
    x=nan; return
end

x=xL;%设初值
for ii=1:100  %绝对够用的
    xnext=(xL+xR)/2;
    if abs(xnext-x)<err
        x=xnext; return
    else
        x=xnext;
    end
    y=pmdtrial(pmd0,x,path); %函数在这里修改
    signy=sign(y);
    if signy==signL
        xL=x;
    elseif signy==signR
        xR=x;
    elseif signy==0
        return
    end
end

end
