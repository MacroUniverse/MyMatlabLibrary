% "fr" version of 'trapz()'
% out = zeros(size(fr));
% both row- and column-vector works

function out = fr_trapz(r, fr)
[Nl,Nm] = size(fr);
out = zeros(Nl,Nm);
for ii = 1:Nl
for jj = 1:Nm
    if ~isempty(fr{ii,jj})
        out(ii,jj) = trapz(r, fr{ii,jj});
    end
end
end
end
