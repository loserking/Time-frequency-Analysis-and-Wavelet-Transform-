clc
clear all
close all
 
del_t = 0.0125;    del_f = 0.05;
t = -9:del_t:9;      f = -4:del_f:4;
x = exp(j*t.^2/10-j*3*t).*((t>=-9)&(t<=1))+exp(j*t.^2/2+j*6*t).*exp(-(t-4).^2/10);
tic
y=wdf (x,t,f);
toc

figure;
C= 10000;
image(t,f,abs(y)*C);
colormap(gray(256));
set(gca,'Ydir','normal');
set(gca,'Fontsize', 12);
title('Wigner distribution function of x(t)','Fontsize', 12);
xlabel('Time (Sec)','Fontsize', 12) ;
ylabel('Frequency (Hz)','Fontsize', 12);
