Mtotal=zeros(11,1); Ftotal=zeros(11,1); total=zeros(11,1);
for ii=1:37 
    if ~isempty(buy{ii})
        for jj=1:numel(buy{ii})
            temp=buy{ii}(jj);
            total(temp)=total(temp)+1;
            if any(ii==male_ind)
                Mtotal(temp)=Mtotal(temp)+1;
            else
                Ftotal(temp)=Ftotal(temp)+1;
            end
        end
    end
end