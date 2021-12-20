% calculate matrix elements of two spherical harmonics, using
% y_{l1,l2}^{L,M} as basis
% see ref HeTDSE_eq8
% support symbolic input

function out = yYYy(l1,l2,L,M,l,m,l1_,l2_,L_,M_)
% selection rules
if L ~= L_ || M ~= M_ ...
    || mod(l1 + l2 + l1_ + l2_ , 2) == 1
    out = 0; return;
end

[Ndim, m1max] = CGtableDim(l1, l2, M);
m1 = m1max:-1:m1max-Ndim+1;
m2 = M-m1;
[Ndim_, m1max_] = CGtableDim(l1_, l2_, M_);
m1_ = m1max_:-1:m1max_-Ndim_+1;
m2_ = M_-m1_;

for i = Ndim:-1:1
    for i_ = Ndim_:-1:1
        terms(i,i_) = term_fun(l1,m1(i),l2,m2(i),L,M,...
            l,m, l1_,m1_(i_),l2_,m2_(i_),L_,M_);
    end
end
out = (2*l+1)/(4*pi) * sum(terms(:));
end

function out = term_fun(l1,m1,l2,m2,L,M,l,m,l1_,m1_,l2_,m2_,L_,M_)
out = ThreeJ(l1,0,l,0,l1_,0);
if abs(double(out)) < eps, out = 0; return; end

out = out * ThreeJ(l1,-m1,l,-m,l1_,m1_);
if abs(double(out)) < eps, out = 0; return; end

out = out * ThreeJ(l2,0,l,0,l2_,0);
if abs(double(out)) < eps, out = 0; return; end

out = out * ThreeJ(l2,-m2,l,m,l2_,m2_);
if abs(double(out)) < eps, out = 0; return; end

out = out * CG(l1,m1,l2,m2,L,M);
if abs(double(out)) < eps, out = 0; return; end

out = out * CG(l1_,m1_,l2_,m2_,L_,M_);
if abs(double(out)) < eps, out = 0; return; end

out = out * (-1)^(m1+m2+m)*sqrt((2*l1+1)*(2*l1_+1)*(2*l2+1)*(2*l2_+1));
end
