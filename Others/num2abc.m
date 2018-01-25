% convert number to abc
function abc = num2abc(num)
global callnum
callnum = callnum + 1;
disp(callnum);
N = numel(num);
table = 'a':'z';
for ii = N:-1:1
    abc(ii) = table(num(ii));
end
end