%检查缺页

function num_lost=lost_page

name=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
if isa(name,'char')
    name={name}; 
end
N=numel(name);
num=zeros(N,1);
for ii=1:N
    num(ii)=name2num(name{ii});
end
num_all=(min(num):max(num))';
num_lost=setxor(num_all,num);

end