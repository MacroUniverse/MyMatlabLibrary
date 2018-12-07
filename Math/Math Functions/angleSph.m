% get angle between two unit vectors in spherical coordinates
% matrix input
function alpha = angleSph(th1,ph1,th2,ph2)
alpha = acos(cos(th1).*cos(th1).*cos(ph1-ph2) + sin(th1).*sin(th2));
end
