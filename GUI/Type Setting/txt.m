%处理文本(自动分段,标点半角替换等...)
%width是一行的最大长度
%对HarryPotter,先用some pdf to txt 初步转换,再用gui的edit得到cell数组
%再转换成单行的char数组, 调用该程序处理

function s=txt(s,book)

if strcmp(book,'Harry Potter');
    width=62;
end

%通用处理
s=common(s,width);
s=page_combine(s,book);

end


%基本通用操作
%全角转半角, 自动分段
function s=common(s,width)

s=strrep(s,char(8217),'''');%替换符号:  ’
s=strrep(s,char(8212),'--');%            —
s=strrep(s,char(8220),'"');%             “
s=strrep(s,char(8221),'"');%             ”


%自动分段
Col=1;%当前列
ii=2;
while ii<length(s)-1
    if s(ii)==char(13) %如果检测到回车
        if s(ii+1)==char(13)%如果是连续两个回车
            ii=ii+2;
        elseif s(ii+1)==' '%如果回车后面是空格
            ii=ii+2;
        elseif Col>width*0.8 %如果回车后面是字且上一行已满
            if s(ii-1)=='-' % --  回车  字
                s([ii-1 ii])=[];
            else
                s(ii)=' ';
            end
        else
            ii=ii+1;
        end
        Col=1;
    else %不是回车
        Col=Col+1;
        ii=ii+1;
    end
end

end

%合并页
function s=page_combine(s,book)
if strcmp(book,'Harry Potter')
    %identifier:回车(ii)+空格...数字(temp)...+回车(temp1)+空格.........大写(temp2).....回车(temp3)
    for ii=1:numel(s)
        if ii+1>numel(s)
            break
        end
        if s(ii)==char(13) && s(ii+1)==char(32)
           temp=next_nospace(s,ii+1);
           temp1=next_char(s,temp);
           if s(temp)>='0' && s(temp)<='9'  && s(temp1)==char(13) %确认页码
               temp2=next_nospace(s,temp1);
               if s(temp2)>'A' && s(temp2)<'Z' %确认大写标题
                   temp3=next_CR(s,temp2);
                   delete=[ii+1: temp-1  temp1+1:temp3-1];
                   s(delete)=[];
               end
           end
        end
    end
end
end

%查找上一个回车
function pointer=last_CR(s,pointer)
for ii=pointer-1:-1:1
    if s(ii)==char(13)
        pointer=ii;
        return
    end
end
end

%查找下一个回车
function pointer=next_CR(s,pointer)
N=numel(s);
for ii=pointer+1:N
    if s(ii)==char(13)
        pointer=ii;
        return
    end
end
pointer=nan;%已经是最后一个回车
end

%查找下一个非数字
function pointer=next_char(s,pointer)
N=numel(s);
for ii=pointer+1:N
    if s(ii)<'0' || s(ii)>'9'
        pointer=ii;
        return
    end
end
pointer=nan;%已经是最后一个非数字
end

%查找下一个非空格
function pointer=next_nospace(s,pointer)
N=numel(s);
for ii=pointer+1:N
    if s(ii)~=char(32)
        pointer=ii;
        return
    end
end
pointer=nan;%已经是最后一个非空格
end

%整段右移的识别和处理
function s=letter_form(s)
N=numel(s);
begin=[]; close=[];
for ii=1:N
    if s(ii)==char(13) && all(s(ii+1:ii+4)==char(32))%回车后面连续四个空格
        temp=next_CR(s,ii);
        if temp+4>N
            break
        elseif next_nospace(s,ii)~=char(13) && s(temp+1:temp+4)==char(32) %第一行不为空
                                                                                                               %且第二行也有四个空格(识别成功)
            begin=[begin ii+1];%信件开始
            for jj=1:100%默认不超过100行
                temp=next_CR(temp);
                if temp+4>N || any(s(temp+1:temp+4)~=char(32)) %超出文本或者没有四个空格 
                    close=[close temp];%(temp在最后一行的回车处)
                    break
                elseif jj==20
                    error('书信格式超过20行');
                end
            end
        end
    end
end

min=inf; max=0;
for ii=1:numel(begin)%每次处理一封信,统计起始行和终止列
    temp=begin(ii);
    for jj=1:20
        temp1=next_nospace(s,temp)-temp+1;%该行开始列
        if temp1-temp<min
            min=temp1-temp;
        end
        temp2=next_CR(s,temp);%该行回车列
        if temp2-temp>max
            max=temp2-1;
        end
        temp=next_CR(s,temp)+1;
        if temp>close(ii)
            break
        end
    end
end

end