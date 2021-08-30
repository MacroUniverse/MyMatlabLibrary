% evaluate "fr" function along one line crossing the origin
% 'th', 'ph' are scalars, no range limit, 'r' is the radial grid of 'fr'
% 'r1' will be [-fliplr(r),r], f will be corresponding function values
% all vectors must be row vectors

function [f,r1] = fr2_eval1(data,l,m,r,th,ph,scaled)
f1 = fr2_eval(data,l,m,r,th+pi,ph,scaled); % negative r
if r(1) < eps, f1 = f1(2:end); end
f2 = fr2_eval(data,l,m,r,th,ph,scaled); % positive r
f = [fliplr(f1.'), f2.'];

if nargout == 2
    if r(1) < eps
        r1 = [-fliplr(r(2:end)), r];
    else
        r1 = [-fliplr(r), r];
    end    
end
end
