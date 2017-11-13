%Assuming D=1;
%x has the unit of a
for jj=1:6
    E=E0(jj);
    t1=(20*pi^2)^(1/3);
    t2=sqrt(-20*pi^2*E);

    Mat=[Ai(-t1*E)           Bi(-t1*E)           
         t1*Ai1(-t1*E)       t1*Bi1(-t1*E) ];   
    b=[exp(-t2); -t2*exp(-t2)];
    temp=Mat\b;
    C1=temp(1);
    C2=temp(2);

    Nplot=1000;
    phi=zeros(1,Nplot);
    x=linspace(0,3,Nplot);
    for ii=1:Nplot
        if x(ii)<1
          phi(ii)=C1*Ai(t1*x(ii)-t1*(1+E))+C2*Bi(t1*x(ii)-t1*(1+E));
        else
          phi(ii)=exp(-t2*x(ii));
        end
    end
    figure; hold on; grid on
    title(['Wave Function for the ' num2str(jj) 'th Energy Level  E=' num2str(E) 'V0']);
    xlabel('x in unit of a');
    plot(x,phi,'r'); 
    if mod(jj,2)==0
        plot(-x,-phi,'r');
    else
        plot(-x,phi,'r');
    end
end