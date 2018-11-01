% cut the central part of the wave function

function fr = fr_cut(fr,N)
[Nl, Nm] = size(fr);
for ii = 1:Nl
for jj = 1:Nm
    if ~isempty(fr{ii,jj})
        fr{ii,jj}(1:N) = 0;
    end
end
end
end
