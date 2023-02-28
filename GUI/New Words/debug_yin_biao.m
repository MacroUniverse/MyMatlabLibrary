%debug yin_biao
load wordbook.mat phonetic

name={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',.....
           'a1','a2','ae','colon','down','e1','epsilon','eta','i1','j1','o1','s1','th','theta',......
           'theta1','theta2','u1','up' ,'up2','space','minus','(',')', ';','[',']','slash',......
           ........%  question一定要放到最后!!!
           'question'};%相片的名称
Nname=numel(name);
M=cell(Nname,1);
for ii=1:Nname
    M{ii}=imread([name{ii} '.bmp']);
    M{ii}=M{ii}(:,:,1);
end

figure
for ii=1:23
    I=yin_biao(phonetic{ii},name,M);
    pause(0.1)
    imshow(I);
end
