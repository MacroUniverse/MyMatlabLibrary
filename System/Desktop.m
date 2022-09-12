% return windows desktop directory
% if use any input, 'cd' to the desktop directory
% 'path' ends with '\'

function path = Desktop(varargin)
if ispc
    [~, path] = system('echo %USERPROFILE%');
    path = [path(1:end-1), '\Desktop\'];
else
    [~, path] = system('echo $HOME');
    path = [path(1:end-1), '/Desktop/'];
end
if nargin > 0
    cd(path);
end
end
