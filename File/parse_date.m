% e.g. 16-Jun-2019 to 20190616
function yyyymmdd = parse_date(str)
inds = strfind(str, '-');
if (numel(inds) ~= 2)
    error("unknown!");
end
dd = str(1:inds(1)-1);
if numel(dd) == 1
    dd = ['0', dd];
end
month = str(inds(1)+1:inds(2)-1);
if (strcmp(month, 'Jan'))
    mm = '01';
elseif (strcmp(month, 'Feb'))
    mm = '02';
elseif (strcmp(month, 'Mar'))
    mm = '03';
elseif (strcmp(month, 'Apr'))
    mm = '04';
elseif (strcmp(month, 'May'))
    mm = '05';
elseif (strcmp(month, 'Jun'))
    mm = '06';
elseif (strcmp(month, 'Jul'))
    mm = '07';
elseif (strcmp(month, 'Aug'))
    mm = '08';
elseif (strcmp(month, 'Sep'))
    mm = '09';
elseif (strcmp(month, 'Oct'))
    mm = '10';
elseif (strcmp(month, 'Nov'))
    mm = '11';
elseif (strcmp(month, 'Dec'))
    mm = '12';
end
yyyy = str(inds(2)+1:inds(2)+4);
yyyymmdd = [yyyy, mm, dd];
end