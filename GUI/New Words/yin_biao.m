%输入代码数组, 显示音标图片
%需要"音标.mat"文件
%numel(String)=N; 
%String中每个元胞都必须在name中找到对应的元胞, 否则会报错
%M是name对应的图片矩阵, 最好是int8格式的m*n*1矩阵, 注意高度要一致,否则拼接会出错.

%以下是生成name数组和M数组的方法:

%name={'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',.....
%           'a1','a2','ae','colon','down','e1','epsilon','eta','i1','j1','o1','s1','th','theta',......
%           'theta1','theta2','u1','up' ,'up2','space','minus','(',')', ';','[',']','slash',......
%           ........%  question一定要放到最后!!!
%           'question'};%相片的名称
%Nname=numel(name);
%M=cell(Nname,1);
%for ii=1:Nname
%    M{ii}=imread([name{ii} '.bmp']);
%    M{ii}=M{ii}(:,:,1);
%end


function I=yin_biao(String,name,M)

String=preprocess(String);

N=numel(String);

Nname=numel(name);
ind=zeros(N,1);
for ii=1:N
    for jj=1:Nname
        if strcmp(String{ii},name{jj})
            ind(ii)=jj; break;
        end
    end
end

if any(ind==0)
    temp=find(ind==0);
    ind{temp}=Nname;
    warning(['音标中''' String{temp(1)} ''' 字符在name变量中搜索不到,图片中已用音符代替']);
end
I=[M{ind}];

end

function String=preprocess(String)
for ii=1:numel(String);
    switch String{ii}
        case ''''
            String{ii}='up';
        case ','
            String{ii}='down';
        case ':'
            String{ii}='colon';
        case ' '
            String{ii}='space';
        case '-'
            String{ii}='minus';
        case 'ɡ' %char(609)
            String{ii}='g';
        case 'θ' %char(952)
            String{ii}='theta';
        case '?' %char(63)
            String{ii}='eta';
        case 'ɑ' %char(593)
            String{ii}='a1';
        case 'ε' %char(949)
            String{ii}='epsilon';
        case '/'
            String{ii}='slash';
    end
end
end





