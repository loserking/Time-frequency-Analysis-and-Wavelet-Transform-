clc
clear all
close all
 
x=imread('lena.bmp');
figure;
imshow(x);
title('Lena','Fontsize',12);
x=double(x);
 
y=wavelet8D_iwavelet8D(x);
 
y=uint8(y);
imwrite(y,'Lena_recon.bmp','BMP');
 
x_recon=imread('Lena_recon.bmp');
figure;
imshow(x_recon);
title('Lena recon','Fontsize',12);
