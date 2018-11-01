% take conjugate of an "fr" function

function fr = fr_conj(fr)
[Nl, Nm] = size(fr);
for ii = 1:Nl
for jj = 1:Nm
    if ~isempty(fr{ii,jj})
        fr{ii,jj} = conj(fr{ii,jj});
    end
end
end
end
