%执行完主程序后，执行此以演示整个过程的动画
%执行完主程序后，执行此以演示整个过程的动画
pause(2)

for i=1:length(yy(:,1))
    plot(yy(i,:));axis([0,length(SV0)/2,-3,3]);
    pause(0.0000001)
    if i==1
        pause(5)
    end
end
