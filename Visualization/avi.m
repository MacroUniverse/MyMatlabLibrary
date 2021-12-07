close all;
v = VideoWriter('peaks.avi');
v.FrameRate = 15;
open(v);
Z = peaks;
surf(Z);
axis tight manual
set(gca,'nextplot','replacechildren');
N = 600;
for k = 1:N
   surf(sin(2*pi*k/N)*Z,Z)
   frame = getframe(gcf);
   writeVideo(v,frame);
end

close(v);