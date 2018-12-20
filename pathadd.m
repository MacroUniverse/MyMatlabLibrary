% this function will add current folder and subfolders to Matlab search path
% not including '.git' folder

function pathadd
current_path = fileparts(mfilename('fullpath'));
str = genpath(current_path);
str = strrep(str,'\','/');
str = regexprep(str,'[^;]*.git[^;]*;','');
addpath(str);
end
