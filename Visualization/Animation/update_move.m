function f=update_move(h,x,y,z,dt)
set(h,'xdata',x,'ydata',y,'zdata',z);
drawnow;
pause(dt);
