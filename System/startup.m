% This script is automatically executed when Matlab starts
% make sure this file is in Matlab search path
% remember to 'clear' after each section

%% use old figure toolbar if Matlab version >= 9.5 (R2018b)
% the new one sucks!
v = ver('MATLAB');
int_dot = strfind(v.Version, '.');
vMajor = str2double(v.Version(1:int_dot-1));
vMinor = str2double(v.Version(int_dot+1:end));
if vMajor >= 9 && vMinor >= 5
    set(groot,'defaultFigureCreateFcn',....
        'addToolbarExplorationButtons(gcf)');
    set(groot,'defaultAxesCreateFcn',....
        'set(get(gca,''Toolbar''),''Visible'',''off'')');
end
clear;

%% add more code below
