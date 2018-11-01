% multiply an "fr" function by a scalar or vector (radial function)
% 'v' can also be another "fr" function
function fr = fr_mul(fr, v)
[Nl,Nm] = size(fr);
if ~iscell(v)
    if numel(v) == 1 % 'v' is a scalar
        for jj = 1:Nl
        for kk = 1:Nm
            if isempty(fr{jj,kk}), continue; end
            fr{jj,kk} = fr{jj,kk}*v;
        end
        end
    else      % 'v' is a vector
        for jj = 1:Nl
        for kk = 1:Nm
            if isempty(fr{jj,kk}), continue; end
            fr{jj,kk} = fr{jj,kk}.*v;
        end
        end
    end
else % 'v' is an "fr" function
    for jj = 1:Nl
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        fr{jj,kk} = fr{jj,kk}.*v{jj,kk};
    end
    end
end
end
