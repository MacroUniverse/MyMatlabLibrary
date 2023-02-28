function lat=showLatex(s)
%公式可视化
%输入一个字符串或者符号变量, 函数在新建的figure中用Latex格式显示该公式
figure
hold on
if ischar(s)
    s=sym(s);
elseif ~isa(s,'sym')
    error('class is not char or sym');
end

lat=latex(s);
text(0,-.01,['$' lat '$'],'interpreter','Latex','Fontsize',30)
axis off; axis([0 1 -1 0]*0.1);
hold off

end