% This script is automatically executed when Matlab starts

%% use old figure toolbar if Matlab version >= 9.5 (R2018b)
% the new one sucks!
v = ver('MATLAB');
if str2double(v.Version) > 9.45
    set(groot,'defaultFigureCreateFcn',....
        'addToolbarExplorationButtons(gcf)');
    set(groot,'defaultAxesCreateFcn',....
        'set(get(gca,''Toolbar''),''Visible'',''off'')');
end

%% add more code below
