% resize vector/matrix length for ftt
function y = fftresize(x, newN)
% === x is row vector ===
if size(x, 1) == 1 
    N = numel(x);
    Ndiff = abs(newN - N);
    if newN > N % 0-padding
        if mod(Ndiff,2) == 0
            Ndiff = 0.5*Ndiff;
            y = [zeros(1, Ndiff), x, zeros(1, Ndiff)];
        else
            Ndiff = 0.5*(Ndiff-1);
            if mod(N, 2) == 0
                y = [zeros(1, Ndiff), x, zeros(1, Ndiff+1)];
            else
                y = [zeros(1, Ndiff+1), x, zeros(1, Ndiff)];
            end
        end
    elseif newN < N % shrink
        y = shrink(x, N, Ndiff);
    else
        y = x;
    end

% === x is column vector ===
elseif size(x, 2) == 1
    N = numel(x);
    Ndiff = abs(newN - N);
    if newN > N % 0-padding
        if mod(Ndiff,2) == 0
            Ndiff = 0.5*Ndiff;
            y = [zeros(Ndiff, 1); x; zeros(Ndiff, 1)];
        else
            Ndiff = 0.5*(Ndiff-1);
            if mod(N, 2) == 0
                y = [zeros(Ndiff, 1); x; zeros(Ndiff+1, 1)];
            else
                y = [zeros(Ndiff+1, 1); x; zeros(Ndiff, 1)];
            end
        end
    elseif newN < N % shrink
        y = shrink(x, N, Ndiff);
    else
        y = x;
    end

% === x is matrix ===
else
    [N, Ncol] = size(x);
    Ndiff = abs(newN - N);
    if newN > N % 0-padding
        if mod(Ndiff,2) == 0
            Ndiff = 0.5*Ndiff;
            y = [zeros(Ndiff, Ncol); x; zeros(Ndiff, Ncol)];
        else
            Ndiff = 0.5*(Ndiff-1);
            if mod(N, 2) == 0
                y = [zeros(Ndiff, Ncol); x; zeros(Ndiff+1, Ncol)];
            else
                y = [zeros(Ndiff+1, Ncol); x; zeros(Ndiff, Ncol)];
            end
        end
    elseif newN < N % shrink
        if mod(Ndiff,2) == 0
            Ndiff = 0.5*Ndiff;
            y = x(Ndiff+1:end-Ndiff, :);
        else
            Ndiff = 0.5*(Ndiff-1);
            if mod(N, 2) == 0
                y = x(Ndiff+2:end-Ndiff, :);
            else
                y = x(Ndiff+1:end-Ndiff-1, :);
            end
        end
    else
        y = x;
    end
end
end


function y = shrink(x, N, Ndiff)
    if mod(Ndiff,2) == 0
        Ndiff = 0.5*Ndiff;
        y = x(Ndiff+1:end-Ndiff);
    else
        Ndiff = 0.5*(Ndiff-1);
        if mod(N, 2) == 0
            y = x(Ndiff+2:end-Ndiff);
        else
            y = x(Ndiff+1:end-Ndiff-1);
        end
    end
end
