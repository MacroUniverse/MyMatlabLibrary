%把4维矩阵按照bmp格式储存在当前路径
%filename是4Dmat文件的文件名

function im4save(filename)

load(filename);
prename=who; 

if strcmp(prename{1},'filename');
    prename=prename{2};
else
    prename=prename{1};
end

eval(['Im4D=' prename ';']);
Nphoto=size(Im4D,4);
for ii=1:Nphoto
I=Im4D(:,:,:,ii);
imwrite(I,[prename num2str(ii) '.bmp'],'bmp');
end
end