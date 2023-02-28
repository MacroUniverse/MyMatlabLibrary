%彩色相片转换黑白
name={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'.....
           'a1','a2','ae','e1','epsilon','eta','i1','j1','s1','th','theta','theta1','theta2','u1'};
Nname=numel(name);
for ii=1:Nname
    I=rgb2gray(imread([name{ii} '.bmp']));
    I=I(2:end-1,:);
    imwrite(I,[name{ii} '.bmp'],'bmp');
end