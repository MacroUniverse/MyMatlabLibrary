% get the spot sizes of a serious of photoes files (jpg, png etc.)
% sigma is the radius so that the pixel value (intensity) is 1/e of the center 
% (average) intensity.

% Algorithm
% first normalize the image so that all pixels adds up to 1.
% find the average position weighted by the intensity.
% find sigma using bisection method so that the pixels inside the circule
% is of a certain percentage of the total sum of pixel values.

% 1.Set the background threshold by hand (variable "threshold")
% 2.Use artificial_gaussian.m to generate a set of photoes that immitates
%   actual photoes (position does not matter), used to test fluctuation of
%   sigma.
% 3.input a # to select which photo to decide cropping. The size of the
%   cropping should not be too large, but should not cut the spot in any photo.
%   The cropping will be applied to all photoes. The smaller the crop, the
%   better the gaussian fitting.
% 4.zoom in to the spot within 8s if needed.
% 5.crop the photo



function sigma = spotsize_integral

close all;
calibration = 0; % use 1 standard image to calibrate
sigma0 = 12; % theoretical value for calibration image
threshold = 5; % pixel value that's less than threshold will be set to 0
percent0 =   0.40902444; %the integration ratio within 2/3*r_1/e;
magnify = 3; % for dim images

[imgname, imgpath]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
cd(imgpath);
Nimg = numel(imgname);
if ischar(imgname), imgname = {imgname}; Nimg = 1; end % fix the case of Nimg == 1

% set crop
temp = input('which image to crop (input a number)?');
I = imread(imgname{temp});
if ndims(I) == 3
    I = rgb2gray(I)*magnify;
end
figure; imshow(255-I);
set(gca,'Position',[0.1,0.1,0.8,0.8]);
set(gcf,'Units','normalized','Position',[0.3,0.3,0.4,0.4]);

display('please adjust the picture (8s)'); 
pause(4); crop = round(ginput(2));
% crop =  [16    43
%   160   136];

% crop all img
Icrop = cell(Nimg); %zeros(crop(2,2)-crop(1,2)+1, crop(2,1)-crop(1,1)+1, Nimg);
sigma = zeros(1,Nimg);
percent = zeros(1,Nimg);

for ii = 1:Nimg
    disp([num2str(ii),'...']);
    
    I = imread(imgname{ii});
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    Icrop{ii} = I(crop(1,2):crop(2,2), crop(1,1):crop(2,1));
    
    % background removal
    Idb = Icrop{ii}*magnify;
    Idb(Idb <= threshold*magnify) = 0;
    figure; imshow(Idb); hold on;
    set(gca,'Position',[0.1,0.1,0.8,0.8]);
    set(gcf,'Units','normalized','Position',[0.3,0.3,0.4,0.4]);
    
    % find the "center of mass" for the spot center
    
    total = sum(sum(Idb)); Idb = double(Idb)/total; % normalize
    [N1,N2] = size(Idb);
    [Y,X]=ndgrid(1:N1,1:N2);
    temp_x = Idb.*X;
    CM_x = sum(sum(temp_x));
    temp_y = Idb.*Y;
    CM_y = sum(sum(temp_y));
    % scatter(CM_x,CM_y);
    
    % find radius of 1/e intensity
    
    % do simulation for actual value, for r = 2/3 sigma
    % in the end, sigma = sigma * 3/2 sigma
    % 0.433 for sigma = 9
    % 0.431 for sigma = 7.4  err = 0.1

    R = sqrt((X-CM_x).^2 + (Y-CM_y).^2);
    %f = @(r)sum(sum(Idb(R<r))) - percent0;
    options = optimset('TolX',0.0001);
    if calibration == 1
        percent(ii) = f(sigma0*2/3,Idb,R,0);
    else
        sigma(ii) = fzero(@(r)f(r,Idb,R,percent0),[0,round(min(N1,N2)/2)],options);
        sigma(ii) = sigma(ii)*3/2;
    end
    % plot a circle
    th = linspace(0,2*pi,50);
    plot(sigma(ii)*cos(th)+CM_x,sigma(ii)*sin(th)+CM_y,'r');
end

figure; plot(sigma); ylabel('\sigma'); xlabel('image #');

if calibration == 1;
    disp('percent =');
    disp(percent);
    format long;
    disp('percent0 =');
    disp(mean(percent));
    format short
end

end


function percent = f(r,Idb,R,percent0)
    percent = sum(sum(Idb(R<r))) - percent0;
end


