% call-back function for "surf()" data-tip
% show color value as well, can also control precision

function output_txt = datatip(obj,event_obj)
% Display the position of the data cursor
% obj          Currently not used (empty)
% event_obj    Handle to event object
% output_txt   Data cursor text string (string or cell array of strings).

% === set precision here ===
precision = 8;

pos = get(event_obj,'Position');
output_txt = {['X: ',num2str(pos(1),precision)],...
    ['Y: ',num2str(pos(2),precision)]};

% If there is a Z-coordinate in the position, display it as well
if length(pos) > 2
    output_txt{end+1} = ['Z: ',num2str(pos(3),precision)];
end

mark = event_obj.Target.XData(:) == pos(1);
mark = mark & event_obj.Target.YData(:) == pos(2);
if length(pos) > 2
    mark = mark & event_obj.Target.ZData(:) == pos(3);
end
output_txt{end+1} = ['C: ', num2str(event_obj.Target.CData(mark),precision)];
end
