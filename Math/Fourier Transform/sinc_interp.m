% sinc_interp

function y = sinc_interp(x, x0, y0)
    N0 = numel(x0);
    y = zeros(size(x));
    dx0 = (max(x0)-min(x0))/(numel(x0)-1);
    a = pi/dx0;
    for ii = 1:N0
        y = y + y0(ii).*sinc(a*(x-x0(ii)));
    end
end

function y = sinc(x)
    mask = (x~=0);
    y(mask) = sin(x(mask))./x(mask);
    y(~mask) = 1;
end
