% write a string to a file

function filewrite(file_name, str)
fid = fopen(file_name, 'wt');
fprintf(fid, str);
fclose(fid);
end
