% convert one .matt files in the current folder to .mat file
function matb2mat(fname)
varnames = matbload(fname);
save(fname(1:end-1), varnames{:});
end