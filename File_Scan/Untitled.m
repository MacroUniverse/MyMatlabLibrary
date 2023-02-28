%非线性拼接程序

fixed = dicomread('knee1.dcm');
moving = dicomread('knee2.dcm');
figure, imshowpair(moving, fixed, 'montage')
title('Unregistered')
figure, imshowpair(moving, fixed)
title('Unregistered')
[optimizer,metric] = imregconfig('multimodal');
tic
movingRegisteredDefault = imregister(moving, fixed, 'affine', optimizer, metric);
timeDefault = toc

figure, imshowpair(movingRegisteredDefault, fixed)
title('A: Default registration')
