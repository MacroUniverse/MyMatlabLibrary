%初始化wordbook.mat存档

function reset_wordbook
    word={[]}; phonetic={[]}; string={[]}; tags={[]};
    save wordbook.mat word phonetic string tags
end