% my version of imagesc
% y axis points up
% gain (optional argument) is done by saturating high intensity
% if gain is not set, 0 = darkest, max(I(:)) = brightest

function Imagesc(x, y, I, gain)
InvGain = 1/gain;
% if ~isreal(I(:))
%     warning('I must be a real matrix! displaying abs(I)');
%     I = abs(I);
% end
if nargin > 3
    threashold = max(abs(I(:)))*InvGain;
    I(abs(I) > threashold) = threashold;
    imagesc(x, y, flipud(I),[min(I(:)),threashold]); colorbar;
else
    imagesc(x, y, flipud(I),[min(I(:)),max(I(:))]); colorbar;
end
xlabel('x'); ylabel('y'); 
colormap('gray');
axis image; view([0,-90]);
end