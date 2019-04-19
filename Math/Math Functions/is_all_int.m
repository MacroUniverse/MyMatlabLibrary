% test if A is an array of integer numbers round(A) = A
function out = is_all_int(A)
out = isequal(round(A),A);
end
