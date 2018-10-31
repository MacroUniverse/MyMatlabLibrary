% multiply an "fr" function by a scalar or vector (radial function)
function fr = fr_mul(fr, v)
[Nl,Nm] = size(fr);
if numel(v) == 1
    for jj = 1:Nl
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        fr{jj,kk} = fr{jj,kk}*v;
    end
    end
else
    for jj = 1:Nl
    for kk = 1:Nm
        if isempty(fr{jj,kk}), continue; end
        fr{jj,kk} = fr{jj,kk}.*v;
    end
    end
end
end
