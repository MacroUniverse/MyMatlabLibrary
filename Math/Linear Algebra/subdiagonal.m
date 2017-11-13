% Creat symmetric subdiagonal Matrix
% list is a column or row matrix

function Mat=subdiagonal(list)
Mat=zeros(numel(list)+1);
for ii=1:numel(list)
    Mat(ii,ii+1)=list(ii);
    Mat(ii+1,ii)=list(ii);
end
end