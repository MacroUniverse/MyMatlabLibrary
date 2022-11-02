% 所有的 unicdoe 汉字
% https://www.qqxiuzi.cn/zh/hanzi-unicode-bianma.php
tab = { 0x4E00 0x9FA5 '基本汉字'
        0x9FA6 0x9FFF '基本汉字补充（编码紧接上一行）'
        0x3400 0x4DBF '扩展A'
        0x20000 0x2A6DF '扩展B'
        0x2A700 0x2B739 '扩展C'
        0x2B740 0x2B81D '扩展D'
        0x2B820 0x2CEA1 '扩展E'
        0x2CEB0 0x2EBE0 '扩展F'
        0x30000 0x3134A '扩展G'
        0x31350 0x323AF '扩展H'
        0x2F00 0x2FD5 '康熙部首'
        0x2E80 0x2EF3 '部首扩展'
        0xF900 0xFAD9 '兼容汉字'
        0x2F800 0x2FA1D '兼容扩展'
        0x31C0 0x31E3 '汉字笔画'
        0x2FF0 0x2FFB '汉字结构'
        0x3105 0x312F '汉语注音'
        0x31A0 0x31BF '注音扩展'
        0x3007 0x3007 '〇'};

Nintv = size(tab1, 1);
for i = 1:Nintv
    tab{i,1} = double(tab{i,1});
    tab{i,2} = double(tab{i,2});
end

% count num char
nchar = cell(Nintv,1);
for i = 1:Nintv
    nchar{i} = tab{i,2}-tab{i,1}+1;
    if nchar{i} < 1
        error('illegal range!');
    end
end
tab = [tab(:,1:2) nchar tab(:,3)];

% sort
tab1 = [tab{:,1}].';
[tab1, order] = sort(tab1);
tab = tab(order, :);

% check
for i = 1:Nintv-1
    if tab{i+1,1} <= tab{i,2}
        error('overlap!');
    elseif tab{i+1,1} == tab{i,2} + 1
        % warning('contguous!');
    end
end

disp(tab)