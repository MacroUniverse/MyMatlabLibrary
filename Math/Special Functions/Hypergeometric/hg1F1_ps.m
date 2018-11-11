% evaluate 1F1(x) using power series

function y = hg1F1(a, b, x, N)
digits(330);
a = vpa(a); b = vpa(b); x = vpa(x);
c = vpa(zeros(1,N+1));
c(1) = 1; c(2) = a/b;
for ii = 1:N-1
    c(ii+2) = c(ii+1)*(a+ii)/((b+ii)*(ii+1));
end
disp('error = ');
disp(double(abs(c(end)*x^N)));

% eval polynormial
y(N+1) = c(N+1);
for ii = N:-1:1
    y(ii) = y(ii+1)*x + c(ii);
end
y = y(1);
end
