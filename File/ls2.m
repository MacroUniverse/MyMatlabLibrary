% same as ls(arg) for Windows
% but also works for Linux/Mac
function str = ls2(arg)
if ispc
    str = ls(arg);
else
    [~, str] = system(['ls ' arg ' -1']);
    cs = splitlines(str); cs = cs(1:end-1);
    for i = 1 : numel(cs)
        if cs{i}(1) == '''' && cs{i}(end) == ''''
            cs{i} = cs{i}(2:end-1);
        end
    end
    str = char(cs);
end
end
