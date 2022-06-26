% convert all .matb files in the current folder and subfolders to .mat files
function matb2mat_all(replace)
    names = dir('**/*.matb');
    for ii = 1:numel(names)
        fname = [names(ii).folder '\' names(ii).name];
        disp(fname);
        matb2mat(fname);
        if nargin == 1
            delete(fname);
        end
    end
end
