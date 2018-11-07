% return the full directory and name of the current ".m" file
% 'path' has '\' ending
% 'name' does not include '.m'

function [path, name] = mfilepath
s = dbstack(1,'-completenames');
path = s(1).file;
name = s(1).name;
path = strrep(path, ['\', name, '.m'], '\');
end
