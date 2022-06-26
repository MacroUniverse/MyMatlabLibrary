% read ".matb" data file
% varnames is a cell array containing the names of the variables exported
% use mattload(fname, 'var1', 'var2', ...) to load specific variables

function names = matbload(fname, varargin)
Nvar = 0;
names = cell(1,Nvar);
fid = fopen(fname, 'r');

for ii = 1:Nvar
    Nname = fread(fid, 1, 'int64');
    names{ii} = fread(fid, [1,Nname], '*char');
    matclass = fread(fid, 1, 'int64'); % 21:double, 41:complex
    ndim = fread(fid, 1, 'int64');
    if (ndim == 0) % scalar
        matsize = [1,1];
    elseif (ndim == 1)
        matsize = [1,fread(fid, 1, 'int64')];
    else % ndim > 1
        matsize = fread(fid, [1,ndim], 'int64');
    end
    matnumel = prod(matsize);
    if numel(varargin) == 0
        load_it = true;
    else
        load_it = false;
        for jj = 1:numel(varargin)
            if strcmp(names{ii}, varargin{jj})
                load_it = true; break;
            end
        end
    end
    if (load_it)
        if matclass == 21 % double
            data = fread(fid, matnumel, 'double');
        elseif matclass == 41 % complex
            data = fread(fid, matnumel*2, 'double');
            data = data(1:2:end) + 1i*data(2:2:end);
        else
            error('not implemented!');
        end
        data = reshape(data, matsize);
        assignin('caller', names{ii}, data);
    else
        if matclass == 21 % double
            seekg(fid, matnumel*8, 'cof');
        elseif matclass == 41 % complex
            seekg(fid, matnumel*16, 'cof');
        else
            error('not implemented!');
        end
    end
end
end
