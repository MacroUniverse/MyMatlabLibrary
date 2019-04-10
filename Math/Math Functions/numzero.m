% find the number of zeros of a function
% the i-th zero is in [ind(i),ind(i+1)]
% does not include boundaries
function [N, ind] = numzero(y)
Sign=sign(y);
ind=find(Sign(1:end-1).*Sign(2:end)<0);
N = numel(ind);
end
