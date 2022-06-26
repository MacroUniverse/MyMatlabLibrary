% convert one .matt files in the current folder to .mat file
function matb2mat(matb_fname)
matb_varnames = matbload(matb_fname);
save(matb_fname(1:end-1), matb_varnames{:});
end
