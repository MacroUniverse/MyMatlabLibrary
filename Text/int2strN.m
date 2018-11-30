% convert a single integer to string
% use optional 'N' to fix the length by 0 padding, not including sign
% 'N' must not be smaller than the digits of 'num', will check
% use 'signed' (optional) to add '+' or '-' before, default is false
% when 'signed' is false num must be non-negative
% in theory, one can use something like num2str(l(jj),'%03.f'), but this is
    % more convenient

function str = int2strN(num, N, signed)
if ~exist('signed','var') || isempty(signed)
    signed = false;
end
if ~signed
    if num < 0, error('use "signed = true" for "num < 0" !'); end
    str0 = num2str(round(num)); N0 = numel(str0);
    if N > N0
        str = char(zeros(1,N));
        str(1:N-N0) = '0';
        str(N-N0+1:end) = str0;
    elseif N == N0
        str = str0;
    elseif N < N0
        error('N is too small!');
    end
else % signed
    str0 = num2str(abs(round(num))); N0 = numel(str0);
    str = char(zeros(1,N+1));
    if N > N0
        str(2:N-N0+1) = '0';
        str(N-N0+2:end) = str0;
    elseif N == N0
        str(2:end) = str0;
    elseif N < N0
        error('N is too small!');
    end
    if num >= 0
        str(1) = '+';
    else
        str(1) = '-';
    end
end
end
