%找到空间中距离最近的两点

function P=Pnearest2(P)

N=size(P,1);
min=1e30;
for ii=1:N
    for jj=ii+1:N
        mag=vmag(P(ii,:)-P(jj,:));
        if mag<min
            min=mag;
            mark=[ii jj];
        end
    end
end
P=P(mark,:);

end