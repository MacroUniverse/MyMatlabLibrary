% integrating the product of three generalized spherical harmonics
% <y_{l1,l2}^{L,M}|y_{l,l}^{0,0}|y_{l1_,l2_}^{L_,M_}>
% see PhysWiki \label{HeTDSE_eq9}
% supports symbolic input

function out = yyy(l1,l2,L,M,l,l1_,l2_,L_,M_)
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

if any(issym(l1,l2,L,M,l,l1_,l2_,L_,M_))
    terms(Ndim,Ndim_) = sym(0);
else
    terms(Ndim,Ndim_) = 0;
end

for i = 1:Ndim
    for i_ = 1:Ndim_
        if abs(m1_(i_)-m1(i)) > l || abs(m2_(i_)-m2(i)) > l
            continue;
        end
        terms(i,i_) = term_fun(l1,m1(i),l2,m2(i),L,M,...
            l, l1_,m1_(i_),l2_,m2_(i_),L_,M_);
    end
end
out = (-1)^l/(4*pi)*sqrt((2*l+1)*(2*l1+1)*(2*l1_+1)*(2*l2+1)*(2*l2_+1))...
    * sum(terms(:));
end

function out = term_fun(l1,m1,l2,m2,L,M,l,l1_,m1_,l2_,m2_,L_,M_)
out = ThreeJ(l1,0,l,0,l1_,0);
if CG_check_0(out), out = 0; return; end

out = out * ThreeJ(l1,-m1,l,m1-m1_,l1_,m1_);
if CG_check_0(out), out = 0; return; end

out = out * ThreeJ(l2,0,l,0,l2_,0);
if CG_check_0(out), out = 0; return; end

out = out * ThreeJ(l2,-m2,l,m2-m2_,l2_,m2_);
if CG_check_0(out), out = 0; return; end

out = out * CG(l1,m1,l2,m2,L,M);
if CG_check_0(out), out = 0; return; end

out = out * CG(l1_,m1_,l2_,m2_,L_,M_);
if CG_check_0(out), out = 0; return; end

out = out * (-1)^(m1_+m2);
end
