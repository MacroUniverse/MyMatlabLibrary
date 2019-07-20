% filename number re-format
% from fixed digit to flexible digit
% choose files that needs to rename

cd(mfilepath);
[filename, path] = uigetfile('*.*', 'multiselect', 'on');
cd(path);
Nfile = numel(filename);
for i = 1:Nfile
    num = str2double(filename{i}(4:7));
    new_name = ['Psi' num2str(num) '.matt'];
    disp(['rename ' filename{i} ' to ' new_name]);
    movefile(filename{i}, new_name);
end
cd(mfilepath);
