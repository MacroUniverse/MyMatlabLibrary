%求射线上一点P输入直线L(六参数),以及R,
%size(L)=[N,6]
%size(R)=[N,1]或size(R)=[1,1]

function P=LR2P(L,R)

N=size(L,1);

if N==1
  P=L(1:3)+L(4:6)*R;
elseif N>1
  if numel(R)==1
      R=ones(N,1)*R;
  end
  P=L(:,1:3)+[R(:) R(:) R(:)].*L(:,4:6);
end

end