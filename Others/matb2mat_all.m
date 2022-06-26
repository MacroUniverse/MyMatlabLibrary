% convert all .matt files in the current folder to .mat files
function matb2mat_all(replace)
names = ls('*.matb');
for ii = 1:size(names,1)
    disp(names(ii,:));
    matb2mat(strtrim(names(ii,:)));
    if nargin == 1
        delete(names(ii,:));
    end
end
end
