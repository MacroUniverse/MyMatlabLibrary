function code_gen(Ty, Ta, Tx)
cd(Desktop);
str = fileread('mul_gen.tmp.cpp');
str = strrep(str, '@Ty@', Ty);
str = strrep(str, '@Ta@', Ta);
str = strrep(str, '@Tx@', Tx);
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
disp(code);
end
