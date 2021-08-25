% turn_demo

A = [1,-1,0];
X = [0,1,1,0,0]; Y = [0,0,1,1,0]; Z = [0,0,0,0,0];
figure; plot3(X, Y, Z);
grid on; hold on; axis equal;
xlabel x; ylabel y; zlabel z;
view(40,40);

P1 = turn([X(:) Y(:) Z(:)],A,pi/10);
P2 = turn([X(:) Y(:) Z(:)],A,pi/5);
plot3(P1(:,1), P1(:,2), P1(:,3));
plot3(P2(:,1), P2(:,2), P2(:,3));
