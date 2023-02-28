%该函数实现windows屏幕截图功能, 相当于按下键盘的PrintScreen键, 然后访问剪切板
%若没有输入,返回RGB图, 若输入N, 返回N色的索引图
%实测每次截图要用0.3s

function [IMDATA, map]=printScreen(N)

%模拟键盘, 按下并松开printscreen按键

%temp=import;
%idx=strfind(temp,'Robot'); %import函数返回所有import内容的名称元胞; strfind返回元胞
% if isempty(idx) || all(cellfun(@isempty,idx)) %cellfun对每一个元胞作用, 返回一个vector.
import java.awt.Robot;
import java.awt.event.*;
 %end

robot=Robot;
robot.keyPress(KeyEvent.VK_PRINTSCREEN);
robot.keyRelease(KeyEvent.VK_PRINTSCREEN);

%访问剪切板, 读出GRB图
IMDATA=[];
while isempty(IMDATA)
    IMDATA = imclipboard('paste');
end


if nargin==1
    [IMDATA, map]=rgb2ind(IMDATA,N);
end

end