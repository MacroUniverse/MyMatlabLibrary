% same as ls(arg) for Windows
% but also works for Linux/Mac
function str = ls2(arg)
if ispc
    str = ls(arg);
else
    [~, str] = system(['ls ' arg ' -1']);
    str = char(splitlines(str));
    str = str(1:end-1, :);
end
end
