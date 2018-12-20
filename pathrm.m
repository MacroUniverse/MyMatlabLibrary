% this function will remove current folder and subfolders from Matlab search path

function pathrm
current_path = fileparts(mfilename('fullpath'));
str = genpath(current_path);
str = strrep(str,'\','/');
str = regexprep(str,'[^;]*.git[^;]*;','');
rmpath(str);
end
