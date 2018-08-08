% read ".matt" data file
% consider using A = fscanf(fileID,formatSpec,sizeA) to read data in
% different class types. Thus saving space.

function mattread(fname)
%fileID = fopen(fname,'r');
%if fileID == -1, error('file does not exist'); end
%data = fscanf(fileID, '%f');
data = dlmread(fname);
ind = 1;
nvar = data(end);
for ii = 1:nvar
    namesize = data(ind); ind = ind + 1;
    varname = char(data(ind : ind+namesize-1))';
    ind = ind + namesize;
    matclass = data(ind); ind = ind + 1;
    ndim = data(ind); ind = ind + 1;
    if (ndim == 0) % scalar
        matsize = [1,1];
    elseif (ndim == 1)
        matsize = [1,data(ind)];
        ind = ind + 1;
    else % ndim > 1
        matsize = data(ind : ind+ndim-1)';
        ind = ind + ndim;
    end
    if matclass == 0 || matclass == 1
        A = zeros(matsize);
    elseif matclass == 2
        A = int32(zeros(matsize));
    elseif matclass == 3
        A = uint8(zeros(matsize));
    end
    matnumel = prod(matsize);
    A(:) = data(ind:ind+matnumel-1);
    ind = ind + matnumel;
    assignin('caller',varname,A);
end
%fclose(fileID);
end