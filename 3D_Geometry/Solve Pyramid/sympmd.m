%sym solve pmd
%目前最满意的全解方法, 但耗时多

function P=sympmd(pmd0)

%tic
x1=pmd0(1); x2=pmd0(2);   x3=pmd0(3);    c12=cos(pmd0(4));
y1=pmd0(5); y2=pmd0(6);   y3=pmd0(7);    c23=cos(pmd0(8));
z1=pmd0(9); z2=pmd0(10); z3=pmd0(11);   c31=cos(pmd0(12));

%toc=0

%tic
B12=sqrt((x1-x2)^2+(y1-y2)^2+(z1-z2)^2);
B23=sqrt((x2-x3)^2+(y2-y3)^2+(z2-z3)^2);
B31=sqrt((x3-x1)^2+(y3-y1)^2+(z3-z1)^2);

B12=num2str(B12,20); B23=num2str(B23,20); B31=num2str(B31,20);
c12=num2str(c12,20); c23=num2str(c23,20); c31=num2str(c31,20);

syms x real positive
syms y real positive
syms z real positive

f1=['x^2+y^2-2*x*y*' c12 '=' B12 '^2'];
f2=['y^2+z^2-2*y*z*' c23 '=' B23 '^2'];
f3=['z^2+x^2-2*z*x*' c31 '=' B31 '^2'];
solves=solve(f1,f2,f3,'x','y','z');%得出的solves是sym格式,列向量

x=solves.x; y=solves.y; z=solves.z; 
x=eval(x); y=eval(y); z=eval(z);

Ns=numel(x);
P=zeros(Ns,3);
for ii=1:Ns
    P(ii,:)=pmdL32P(x(ii), y(ii), z(ii), [x1,y1,z1], [x2,y2,z2], [x3,y3,z3] );
end

end