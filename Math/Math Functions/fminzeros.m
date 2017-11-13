% find "all" zeros for a non-negative function in a range
% can be any dimension, function variables is one row vector x=[x1,x2...]
% size(x0) = [Nguess,Ndim]; Nguess is # of initial guesses.
% size(x) = [Nvalid, Ndim]; Nvalid is # of dist zeros in the range.
% zero_err is maximum allowed value for valid |f(x)|
% dist_err is the maximum distance to distinguish two different x.

function x = fminzeros(f,x0,zero_err,dist_err)
[Nguess,Ndim] = size(x0);
x1 = zeros(Nguess,Ndim);

for ii = 1:Nguess
    x1(ii,:) = fminsearch(f,x0(ii,:),...
        optimset('TolFun',1e-10,'TolX',1e-8));
end
x = DistP(x1,dist_err);
Nsol = size(x,1);
mark = true(Nsol,1);
for ii = 1:Nsol
    if abs(f(x(ii,:))) > zero_err, mark(ii) = false; end
end
x = x(mark,:);
end


% Use statistics to distinguish different points

% e.g. when using multiple guesses to search for global solutions, results
%    may be redundent. Use this program to distinguish different solutions

% size(P) = [Np,Ndim], Np is number of points, Ndim is dimension of space.
% if two points are within distance err, they are considered as one point.

function P1 = DistP(P, err)
err2 = err*err;
[Np,Ndim] = size(P);
Ng = 0; % current # of groups;
Ndone = 0;
ii = 0; % current point
GroupNum = zeros(Np,1); % group number of each point

while 1
% find the next ii
if Ndone == Np, break; end;
for kk = ii+1:Np
    if GroupNum(kk) == 0
       ii = kk; Ng = Ng+1; GroupNum(ii) = Ng;
       Ndone = Ndone + 1; break;
    end
end
% find the next jj to compare with ii
for jj = ii+1:Np
    if GroupNum(jj) == 0
       if sum((P(ii,:)-P(jj,:)).^2) <= err2
           Ndone = Ndone + 1;
           GroupNum(jj) = Ng;
       end
    end
end
end

P1 = zeros(Ng,Ndim);
for ii = 1:Ng
    P1(ii,:) = mean(P(GroupNum == ii,:),1);
end

end