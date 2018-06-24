%检查两个球是否会发生碰撞
%需要碰撞列表list, list{ii}就是可能与第ii个球碰撞的序号
%需要求的坐标P, 速度v, 半径R
Tmin=inf;
NextCollision=0;
Collision=cell(size(v));
Tremain=Collision;
for ii=1:numel(list) %ii是较小的球序号
for jj=list{ii} %jj是较大的球序号
    V12=V(ii,:)-V(jj,:); P12=P(ii,:)-P(jj,:);
    Ca=V12*V12'; Cb=V12*P12';Cc=P12*P12'-4*R^2;
    delta=Cb^2-4*Ca*Cb;
    if delta>=0 %会发生碰撞
        Collision{ii}=[Collision{ii} jj];
        temp=(-Cb-sqrt(delta))/2/Ca;
        Tremain{ii}=[Tremain{ii} temp];
        if temp<Tmin
            Tmin=temp; NextCollision=ii;
        end
    end
end
end

