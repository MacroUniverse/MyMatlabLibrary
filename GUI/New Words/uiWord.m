%有道单词本导出文件读取
function uiWord
figure;
hE=uicontrol('Style','edit','max',2,'Units','Normalized','Position',[0 0 0.9 1],'HorizontalAlignment','left','String',{''});
uicontrol('Style','pushbutton','Units','Normalized','Position',[0.9,0.9,0.1,0.1],'String','导入','Callback',@login);


    %导入的程序
    function login(~,~)
        S=get(hE,'String');
        Nrow=numel(S);%每一行为一个元胞
        ind=zeros(Nrow,1); jj=0;
        
        %%
        %判断有几个单词, 每个单词的行号存到ind(jj)里面. 单词的总数是Nword
        for ii=1:Nrow
            if numel(S{ii})>23 && strcmp(S{ii}(1:23),'</item><item>    <word>')
                jj=jj+1; ind(jj)=ii;
            end
        end
        Nword=jj;
        ind=ind(1:Nword);
        
        %%
        %提取一个单词的所有信息
        %word0: 所有的单词; string0: 所有的注释; phonetic0: 所有的音标; tags0: 所有的单词分类
        word0=cell(Nword,1); word0(:)={''}; string0=word0; phonetic0=word0; tags0=word0;
        
        for ii=1:Nword
            %获取当前单词的结束行号(temp)
            if ii+1>Nword%如果是最后一个单词
                temp=Nrow;
            else
                temp=ind(ii+1)-1;
            end
            %一个单词的所有文本s
            for jj=ind(ii):temp
                S{jj}=[S{jj} char(13)];%每个元胞添加换行符
            end
            s=[S{ind(ii):temp}];
            %提取s中不同内容的范围
            word_begin=strfind(s,'<word>')+6;  word_end=strfind(s,'</word>')-1;
            string_begin=strfind(s,'<trans><![CDATA[')+16; string_end=strfind(s,']]></trans>')-1;
            phonetic_begin=strfind(s,'<phonetic><![CDATA[')+19; phonetic_end=strfind(s,']]></phonetic>')-1;
            tag_begin=strfind(s,'<tags>')+6; tag_end=strfind(s,'</tags>')-1;

            %读取单词
            if word_end >= word_begin 
                word0{ii}=s(word_begin:word_end);
            end
            %读取注释
            if string_end >= string_begin
               string0{ii}=s(string_begin:string_end);
            end
            %读取音标
            if phonetic_end > phonetic_begin+1
               temp=s(phonetic_begin:phonetic_end);
               if temp(1)=='['
                   temp=temp(2:end);
               end
               if temp(end)==']'
                   temp=temp(1:end-1);
               end %temp就是赤裸裸的音标代码,其中特殊字符用\...\括起来
               ind1=strfind(temp,'\');
               kk=1; n=1; phonetic0{ii}=cell(20,1);%第kk个特殊字符, 第n个字符, phonetic0{ii}中第jj个元胞
               for jj=1:20
                   if temp(n)~='\'; %非转义音标
                       phonetic0{ii}{jj}=temp(n);
                   else  %转义音标
                       n=ind1(2*kk);
                       phonetic0{ii}{jj}=temp(ind1(2*kk-1)+1:n-1);
                       kk=kk+1;
                   end
                   n=n+1;
                   if n>numel(temp)
                       phonetic0{ii}=phonetic0{ii}(1:jj); break;
                   end
               end
            else
                phonetic0{ii}=[];
            end
            
            %读取分类标签
            if tag_end >= tag_begin
               tags0{ii}=s(tag_begin:tag_end);
            end
        end

    load wordbook.mat word phonetic string tags
    
    %检查重叠的单词，并且保存
    N=numel(word);%原来的单词数
    kk=N;
    N0=numel(word0);%新增的单词数
    word=[word; cell(N0,1)]; phonetic=[phonetic; cell(N0,1)]; 
    string=[string; cell(N0,1)]; tags=[tags; cell(N0,1)];

    if N~=0 %数据库有单词
        
        for ii=1:N0
            temp=0;%0代表没有找到重复，1代表与数据库重复
            for jj=1:kk
                if strcmp(word(jj),word0(ii));%已经存在该单词
                    temp=1;
                    if isempty(tags{jj}), tags(jj)=tags0(ii); end %如果原来没有分类，则补回分类
                    if isempty(phonetic{jj}), phonetic(jj)=phonetic0(ii); end%没有音标，补回音标
                    %string(ii)=string0(jj); %注释完全替换成新的
                    break;
                end
            end
            if temp==0 %无重复，添加在后面
                kk=kk+1; 
                word(kk)=word0(ii); phonetic(kk)=phonetic0(ii);
                string(kk)=string0(ii); tags(kk)=tags0(ii);
            end
        end
        word=word(1:kk); phonetic=phonetic(1:kk);%去除多多余的元胞
        string=string(1:kk); tags=tags(1:kk);
    else %数据库没有单词
        word=word0; phonetic=phonetic0; string=string0; tags=tags0;
    end
    save wordbook.mat word phonetic string tags
    disp('done');
    end

end