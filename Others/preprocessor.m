function code = preprocessor(tp_file, varargin)
str = fileread(tp_file);
ind_meta = strfind(str, '//%');
Nmeta = numel(ind_meta);
Ncell = 2*Nmeta + 1;
cstr = cell(Ncell, 1);
k = 1; cstr{k} = str(1:ind_meta(1)-1); k = k + 1;
is_meta = false(1, Ncell);
for i = 1 : Nmeta - 1
    cstr{k} = get_line(str, ind_meta(i));
    is_meta(k) = true;
    ind = next_line(str, ind_meta(i));
    cstr{k+1} = str(ind : ind_meta(i+1)-1);
    k = k + 2;
end
cstr{k} = get_line(str, ind_meta(end));
is_meta(k) = true;
ind = next_line(str, ind_meta(end));
cstr{k+1} = str(ind : end);
% disp([cstr{:}]); % debug

eval_str = ['code = '''';' newline];
for i = 1 : Ncell
    if (is_meta(i))
        eval_str = [eval_str, cstr{i}(5:end)];
    else
        eval_str = [eval_str, 'code = [code, cstr{', num2str(i), '}];', newline];
    end
end
eval_str = [eval_str, newline];
filewrite('cpp_gen.m', eval_str);
cpp_gen;

ind2 = 0;
while true
    ind1 = find_next(code, '@.*?@', ind2+1) + 1;
    if (isempty(ind1))
        break;
    end
    ind2 = find_next(code, '@', ind1) - 1;
    type = code(ind1:ind2);
    code = strrep(code, ['@' type '@'], eval(type));
end
end
