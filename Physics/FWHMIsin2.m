% FWHMI of wave packets
% FWHMI: full width half maximum intensity
% return the ratio of FWHMI of sin2 (field) wave v.s. total duration
% satisfy: |cos(pi/2 * FWHMIsin2)^2|^2 == 1/2

function ret = FWHMIsin2
    ret = 2*acos(2^(-1/4))/pi;
end
