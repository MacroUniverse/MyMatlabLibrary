%所有连续回车变成单回车
%保证开头无回车,结尾有回车

function str=singleCR(str)

ind=strfind(str,char(13));
mark=true(size(str));
for ii=2:numel(ind)
    if ind(ii-1)+1==ind(ii)
        mark(ind(ii))=false;
    end
end
str=str(mark);

if str(end)~=char(13)
    str=[str char(13)];
end
if str(1)==char(13)
    str=[char(13) str];

end