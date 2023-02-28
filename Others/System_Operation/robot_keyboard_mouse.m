
import java.awt.Robot;
import java.awt.event.*;
robot=Robot;
% 模拟键盘
string='SORRY GIRL, I LOVE MATLAB MUCH THAN YOU.';
commandwindow
for ii=1:length(string)
    %robot.keyPress(KeyEvent.VK_ALT)
    %robot.keyRelease(KeyEvent.VK_S)
    %robot.keyPress(KeyEvent.VK_PRINTSCREEN) %截屏
    robot.keyPress(double(string(ii)));
    robot.keyRelease(double(string(ii)));
end
% 模拟鼠标
robot.mouseMove(100, 100); % 鼠标移动到（100，100）点
robot.mousePress(InputEvent.BUTTON3_MASK ); % 鼠标右键摁下
robot.mouseRelease(InputEvent.BUTTON3_MASK ); % 鼠标右键弹起

