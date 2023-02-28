%找二值图的边界(从指定的点开始找)



   [y, x]= findN(BW,10);      % select a starting point for the trace

   % Determine the boundaries
     hboundtrace = vision.BoundaryTracer; 
     PTS = step(hboundtrace, BW, [x y]);

   % Display the results
     figure, imshow(BW); 
     hold on; plot(PTS(:,1), PTS(:,2), 'r', 'Linewidth',2);
     hold on; plot(x,y,'gx','Linewidth',2); % show the starting point