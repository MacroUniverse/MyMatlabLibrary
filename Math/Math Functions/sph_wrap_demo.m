% sph_wrap debug

N = 1e7;
R = 2*rand(1,N)-1;
Th = 8*pi*rand(1,N) - 4*pi;
Ph = 8*pi*rand(1,N) - 4*pi;
[X,Y,Z] = Sph2Cart(R,Th,Ph);
[R1,Th1,Ph1] = sph_wrap(R,Th,Ph);
[X1,Y1,Z1] = Sph2Cart(R1,Th1,Ph1);
disp(max(abs(X1-X)));
disp(max(abs(Y1-Y)));
disp(max(abs(Z1-Z)));

[R2,Th2,Ph2] = Cart2Sph(X1,Y1,Z1);
disp(max(abs(R2-R1)));
disp(max(abs(Th2-Th1)));
disp(max(abs(Ph2-Ph1)));
