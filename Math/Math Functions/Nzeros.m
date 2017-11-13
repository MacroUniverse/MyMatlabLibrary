% count zeros by function sign on a grid.

function NumZeros = Nzeros(fx, xspan, resolution)
%      or NumZeros = Nzeros(fx)   value-list of f(x).
if nargin == 3
    x = linspace(xspan(1),xspan(2),resolution);
    lastSign = sign(fx(x(1)));
    NumZeros = 0;
    for ii = 2:resolution
        Sign = sign(fx(x(ii)));
        if Sign*lastSign<=0
            NumZeros = NumZeros +1;
            lastSign = Sign;
        end
    end
elseif nargin ==1
    lastSign = sign(fx(1));
    NumZeros = 0;
    for ii = 2:numel(fx)
        Sign = sign(fx(ii));
        if Sign*lastSign<=0
            NumZeros = NumZeros +1;
            lastSign = Sign;
        end
    end
else
    err('Wrong number of Argument')
end
end