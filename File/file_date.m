% get the timestamp (last modified date) of a file
% format yyyymmdd
function date = file_date(fname)
info = dir(fname);
date = info.date;
end
