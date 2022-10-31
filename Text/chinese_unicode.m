% 所有的 unicdoe 汉字
% https://www.qqxiuzi.cn/zh/hanzi-unicode-bianma.php
tab = { 0X4E00 0X9FA5 '基本汉字'
        0X9FA6 0X9FFF '基本汉字补充（编码紧接上一行）'
        0X3400 0X4DBF '扩展A'
        0X20000 0X2A6DF '扩展B'
        0X2A700 0X2B739 '扩展C'
        0X2B740 0X2B81D '扩展D'
        0X2B820 0X2CEA1 '扩展E'
        0X2CEB0 0X2EBE0 '扩展F'
        0X30000 0X3134A '扩展G'
        0X31350 0X323AF '扩展H'
        0X2F00 0X2FD5 '康熙部首'
        0X2E80 0X2EF3 '部首扩展'
        0XF900 0XFAD9 '兼容汉字'
        0X2F800 0X2FA1D '兼容扩展'
        0XE815 0XE86F 'PUA(GBK)部件'
        0XE400 0XE5E8 '部件扩展'
        0XE600 0XE6CF 'PUA增补'
        0X31C0 0X31E3 '汉字笔画'
        0X2FF0 0X2FFB '汉字结构'
        0X3105 0X312F '汉语注音'
        0X31A0 0X31BA '注音扩展'
        0X3007 0X3007 '〇'};

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