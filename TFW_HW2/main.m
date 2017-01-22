clc
clear all
close all
 
[a1, fs]= wavread('Chord.wav');
x= a1(:,1).';    %extract the first channel
 
dtau= 1/fs;  dt= 0.01;  df= 1;
 
S= round(dt/dtau);
tau= 0:dtau:max(x);
 
t= 0:dt:max(tau);
f= 80:df:1000;
sgm= 200;
 
for a=0:10 %run 10 times
tic % start time
y= Gabor (x, tau, t, f, sgm);
toc % end time
end
 
figure;
C= 10000;
image(t,f,abs(y)*C);
colormap(gray(256));
set(gca,'Ydir','normal');
set(gca,'Fontsize', 12);
title('Scaled Gabor of x(t)','Fontsize', 12);
xlabel('Time (Sec)','Fontsize', 12) ;
ylabel('Frequency (Hz)','Fontsize', 12);
