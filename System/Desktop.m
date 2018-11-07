% return windows desktop directory
% if use any input, 'cd' to the desktop directory
% 'path' ends with '\'

function path = Desktop(varargin)
[~, path] = system('echo %USERPROFILE%');
path = [path(1:end-1), '\Desktop\'];
if nargin > 0
    cd(path);
end
end
