function ind = next_line(str, start)
ind = regexp(str(start:end), newline, 'once') + start;
end
