% get the spot sizes of a serious of photoes files (jpg, png etc.)
% sigma is the radius so that the pixel value is 1/e of the center (average) pixel
% value.

% Algorithm
% first summ the pixels values in x and y directions respectively, then
% fit a gaussian curve to it. The background removal is done by sampling 5
% points on both side of the the two curves. 
% sigma = sqrt(sigma_x ^ 2 + sigma_y ^ 2)
% The fitting algorithm is least square using "fminsearch" to find the
% local minimum (usually also the global minimum, or the fitting will be wrong).
% including strip removal algorithm by making a mean displacement to the
% odd columns and rows, respectively.

% 1.select multiple image files from the UI
% 2.input a # to select which photo to decide cropping. The size of the
%   cropping should not be too large, but should not cut the spot in any photo.
%   The cropping will be applied to all photoes. The smaller the crop, the
%   better the gaussian fitting.
% 3.zoom in to the spot within 8s if needed.
% 4.input "seconds to pause" for checking each fitting, sometimes fitting might not be accurate
%   if data or cropping is bad.
% If different cropping for different photoes are required, run multiple
% times and patch the result.



function sigma = spotsize_gaussian

close all;

[imgname, imgpath]=uigetfile({'*.*';'*.bmp';'*.jpg';'*.png'},'File Selector','multiselect','on');
cd(imgpath);
Nimg = numel(imgname);
if ischar(imgname), imgname = {imgname}; Nimg = 1; end % fix the case of Nimg == 1

% set crop
temp = input('which image to crop (input a number)?');
I = imread(imgname{temp});
if ndims(I) == 3
    I = rgb2gray(I);
end
figure; imshow(255-I);
 display('please adjust the picture (8s)'); pause(8);
t_exam = input('seconds to pause for each fitting:');
crop = round(ginput(2));

% crop all img
Icrop = cell(Nimg); %zeros(crop(2,2)-crop(1,2)+1, crop(2,1)-crop(1,1)+1, Nimg);
Ix = cell(Nimg);
Iy = cell(Nimg);
sigma = zeros(1,Nimg);

for ii = 1:Nimg
    disp([num2str(ii),'...']);
    
    I = imread(imgname{ii});
    if ndims(I) == 3
        I = rgb2gray(I);
    end
    Icrop{ii} = I(crop(1,2):crop(2,2), crop(1,1):crop(2,1));
    % figure; imshow(Icrop{ii});
    
    % project along two directions
    Ix{ii} = sum(Icrop{ii},1); Iy{ii} = sum(Icrop{ii},2)';
    
    % strip removal
    temp = mean(Ix{ii}(1:2:end-1) - Ix{ii}(2:2:end));
    Ix{ii}(1:2:end-1) = Ix{ii}(1:2:end-1) - temp;
    temp = mean(Iy{ii}(1:2:end-1) - Iy{ii}(2:2:end));
    Iy{ii}(1:2:end-1) = Iy{ii}(1:2:end-1) - temp;
    Ix{ii}(end) = []; Iy{ii}(end) = [];
    
    % fit to gaussian
    [m,n,sigma_x] = gaussfit(1:numel(Ix{ii}),Ix{ii}); pause(t_exam);
    [m,n,sigma_y] = gaussfit(1:numel(Iy{ii}),Iy{ii}); pause(t_exam);
    sigma(ii) = sqrt(sigma_x^2 + sigma_y^2);
end

figure; plot(sigma); ylabel('\sigma'); xlabel('image #');

end


% guass fitting by least square and minimum search
% fit the curve to y = A*exp(-(x-x0)^2/sigma^2) + y0;
% wave packet must be complete with >4 backgroud points on each side

function [x0,A,sigma,relErr] = gaussfit(x,y)
% initial parameters

N = numel(x);
y0 = 0.5*mean(y(1:5)+y(end-4:end));

[A,ind] = max(y); A = A - y0;
x0 = x(ind); sigma = 0.2*(x(end)-x(1));
ytrim = y - y0;
param0 = [x0,A,sigma];
param = fminsearch(@(param)trial(x,ytrim,param),param0);
x0 = param(1); A = param(2); sigma = param(3);
relErr = trial(x,y,param)/N;

% plot
figure; plot(x, A*exp(-(x-x0).^2/sigma^2)+y0); 
hold on; scatter(x,y); %plot(x,y);
end

function S2 = trial(x,ytrim,param)
x0 = param(1); A = param(2); sigma = param(3);
S2 = sum((ytrim - A*exp(-((x-x0)./sigma).^2)).^2);
end