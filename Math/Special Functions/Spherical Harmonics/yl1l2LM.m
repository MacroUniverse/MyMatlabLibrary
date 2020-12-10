% coupled spherical harmonics
% only supports single value for now
function ret = yl1l2LM(l1, l2, L, M, th1, ph1, th2, ph2)
    [Ndim, m1_max] = CGtableDim(l1, l2, M);
    ret = 0;
    for m1 = m1_max + 1 - Ndim : m1_max
        m2 = M - m1;
        ret = ret + CG(l1, m1, l2, m2, L, M) * ...
            SphHarm(l1, m1, th1, ph1) * SphHarm(l2, m2, th2, ph2);
    end
end
