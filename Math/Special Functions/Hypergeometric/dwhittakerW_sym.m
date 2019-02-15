% whittakerW derivative
% d/dz[whittakerW(a, b, z)]

function [dW, W] = dwhittakerW_sym(a, b, z)
W = whittakerW(a, b, z);
dW = ((z - 2*a).*W - 2*whittakerW(a+1, b, z))./(2*z);
end
