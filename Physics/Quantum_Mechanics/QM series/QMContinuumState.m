%Piecewise Continuum State

function C=ContinuumState(f1,f2,a,g1,g2,odd_even)

h=1e-7;
f1_=@(x) (f1(x+h)-f1(x-h))/(2*h);
f2_=@(x) (f2(x+h)-f2(x-h))/(2*h);
g1_=@(x) (g1(x+h)-g1(x-h))/(2*h);
g2_=@(x) (g2(x+h)-g2(x-h))/(2*h);

if odd_even(1)=='Even'

    A=[f1(a)   f2(a)   -g1(a)   -g2(a)
       f1_(a)  f2_(a)  -g1_(a)  -g2_(a)
       f1_(0)  f2_(0)  0        0    ];

else
    A=[f1(a)   f2(a)   -g1(a)   -g2(a)
       f1_(a)  f2_(a)  -g1_(a)  -g2_(a)
       f1(0)   f2(0)   0        0    ];
end

C=null(A);
end