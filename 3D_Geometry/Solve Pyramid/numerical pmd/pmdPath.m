function [path, path2]=pmdPath(N)
%%
%path(3)
mod3=mod(N,3);
if mod3==1
    path2(3)=1; path(3)=1;
elseif mod3==2
    path2(3)=2; path(3)=1;
else
    path2(3)=3; path(3)=2;
end
%%
%path(2)
mod2=mod(N,9);
if mod2==0
    mod2=9;
end
mod2=ceil(mod2/3);
if mod2==1
    path2(2)=1;  path(2)=1;
elseif mod2==2
    path2(2)=2; path(2)=1;
else
    path2(2)=3; path(2)=2;
end

%%
%path(1)
mod1=ceil(N/9);
if mod1==1
    path2(1)=1; path(1)=1;
elseif mod1==2
    path2(1)=2; path(1)=1;
else
    path2(1)=3; path(1)=2;
end

end