%The determinant to solve the Coefficients of triangle potential bound states

function Det=DetOdd(E,Ai,Bi,Ai1,Bi1)

t1=(20*pi^2)^(1/3);
t2=sqrt(-20*pi^2*E);

%Column1: C1, Column2: C2, Column3: D
Mat=[Ai(-t1*(1+E))       Bi(-t1*(1+E))       0  %Eq1
     Ai(-t1*E)           Bi(-t1*E)           -exp(-t2)
     t1*Ai1(-t1*E)       t1*Bi1(-t1*E)       t2*exp(-t2)];

Det=det(Mat);

end