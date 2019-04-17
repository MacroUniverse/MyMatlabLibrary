% return the dimension of a C-G coefficient table and max(m_1)

function [Ndim, m1max] = CGtableDim(l1, l2, M)
if abs(M) > abs(l1-l2)
    Ndim = l1+l2-abs(M)+1;
else
    Ndim = 2*min(l1,l2)+1;
end
if M >= l1 - l2
    m1max = l1;
else
    m1max = l2+M;
end
end
