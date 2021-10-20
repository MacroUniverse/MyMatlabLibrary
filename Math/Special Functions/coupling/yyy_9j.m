% <y_{l1,l2,L,M}|y_{l,l,0,0}|y_{l1_,l2_,L_,M_}>
function out = yyy_9j(l1,l2,L,M,l,l1_,l2_,L_,M_)
if L ~= L_ || M ~= M_
    out = 0; return;
end

out = CG(l,0,l1_,0,l1,0);
if CG_check_0(out), out = 0; return; end

out = out * CG(l,0,l2_,0,l2,0);
if CG_check_0(out), out = 0; return; end

out = out * Wigner9j(l,l1_,l1,l,l2_,l2,0,L_,L);
if CG_check_0(out), out = 0; return; end

out = out * (2*l+1)/(4*pi)*sqrt((2*l1_+1)*(2*l2_+1)*(2*L_+1));
end
