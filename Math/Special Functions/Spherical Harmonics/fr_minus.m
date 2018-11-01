% subtraction of two "fr" function

function fr = fr_minus(fr1, fr2)
[Nl, Nm] = size(fr1);
fr = cell(Nl,Nm);
for ii = 1:Nl
for jj = 1:Nm
    if ~isempty(fr1{ii,jj})
        fr{ii,jj} = fr1{ii,jj} - fr2{ii,jj};
    end
end
end
end
