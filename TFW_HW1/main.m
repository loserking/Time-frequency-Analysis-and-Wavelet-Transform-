dt=0.05;
df=0.05;
t1=[0:dt:10-dt]; t2=[10:dt:20-dt]; t3=[20:dt:30];
t=[0:dt:30];
f=[-5:df:5];
x=[cos(2*pi*t1),cos(6*pi*t2),cos(4*pi*t3)];
B=1;
tic
y=recSTFT(x,t,f,B);
toc
mesh(abs(y))
mesh(t,f,abs(y))
colormap(gray(256))
set(gca,'Ydir','normal')
set(gca,'Fontsize',12)
xlabel('Time(Sec)','Fontsize',12)
ylabel('Frequency(Hz)','Fontsize',12)
title('STFT of x(t)','Fontsize',12)