%裁剪相片
if 0
I=imread('音标.bmp');
figure; imshow(I); hold on;
N=input('几个字母?');
x=zeros(N,2);
for ii=1:N
    temp=ginput(2);
    x(ii,1)=floor(temp(1)); x(ii,2)=ceil(temp(2));
    Scatter([x(ii,1),1; x(ii,2),1]);
end
M=cell(20,1);

end
for ii=1:N
    %M{ii}=I(1:end,floor(x(2*ii-1)):ceil(x(2*ii)));
    h=figure; imshow(M{ii});
    con=input('修改:any 下一张:[ ]');
    if isempty(con)
        close(h);
    else
        temp=ginput(2);temp=[floor(temp(1)),ceil(temp(2))];
        close(h);
        if temp(1)<1
            temp(1)=1;
        end
        if temp(2)>size(M{ii},2)
            temp(2)=size(M{ii},2);
        end
        M{ii}=M{ii}(:,temp(1):temp(2));
        figure; imshow(M{ii});
    end
end