% extract all integers from a char vector
% 'if signed', '+' or '-' is allowed before numbers,
    % otherwise, they are ignored (default)
% size(name)=[1,N]
% if multiple numbers are found, 'ind' can choose the number, and can be an array.
    % 'ind(ii) = inf' means the last element. By default, return all numbers found.

function num = str2ints(str,signed,inds)
if ~exist('signed','var') || isempty(signed)
    signed = false;
end
if signed
    cell_str = regexp(str,'[+-]*[0-9]+','match');
else
    cell_str = regexp(str,'[0-9]+','match');
end
if exist('inds','var')
    mark = isinf(inds);
    num = zeros(size(inds));
    num(~mark) = str2double(cell_str(inds(~mark)));
    num(mark) = str2double(cell_str(end));
else
    num = str2double(cell_str);
end
end
