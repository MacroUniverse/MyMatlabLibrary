function out = CG_check_0(val)
if issym(val) && val == sym(0) || ~issym(val) && abs(val) < eps
    out = true; return;
end
out = false;
end
