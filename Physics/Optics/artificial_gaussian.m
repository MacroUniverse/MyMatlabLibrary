% artificial gaussian cross section
% save imgs to the current folder

sigma = 7.4;
temp = 10;
[Y0,X0] = ndgrid(-temp*sigma:temp*sigma,-temp*sigma:temp*sigma);
X0 = X0 - 4*sigma;
I0 = 170;


for ii = 1:7
    X = X0 + sigma*ii;
    I = uint8(I0*exp(-(X.^2+Y0.^2)/sigma^2));

    figure; imshow(I,[0,255]);
    set(gca,'Position',[0.1,0.1,0.8,0.8]);
    set(gcf,'Units','normalized','Position',[0.3,0.3,0.4,0.4]);

    imwrite(I,['sigma' num2str(sigma) '_' num2str(ii) '.bmp'],'bmp');

end