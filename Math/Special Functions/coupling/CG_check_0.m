% check if val is 0
% if val is symbolic the check is strict
% if val is numeric check 'abs(val) < eps'
function out = CG_check_0(val)
if issym(val) && val == sym(0) || abs(val) < eps
    out = true; return;
end
out = false;
end
