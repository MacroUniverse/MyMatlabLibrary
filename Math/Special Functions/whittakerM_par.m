% parallel version of whittakerM()
% unfinished!
% only 1.6x better performance on surface?
% better than nothing
% I probably need to learn more about parallel toolbox before preceeding

function z = whittakerM_par(a, b, z)
temp = cell(1,4);
temp{1} = z(1:250);
temp{2} = z(251:500);
temp{3} = z(501:750);
temp{4} = z(751:1000);
parfor ii = 1:4
    temp{ii} = whittakerM(a, b, temp{ii});
end
z = [temp{1} temp{2} temp{3} temp{4}];
end
