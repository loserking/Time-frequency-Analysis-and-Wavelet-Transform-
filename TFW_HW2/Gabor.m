function y=Gabor(x,tau,t,f,sgm)%by R04943133
 
dtau=tau(2)-tau(1);
dt=t(2)-t(1);
df=f(2)-f(1);
 
S= round(dt/dtau);
N= round(1/dtau/df);
B= 1.9143;
Q= floor(B/dtau/sqrt(sgm));
 
n= round(t/dtau/S); % t to n                      
n1= n-round(min(tau)/dtau/S) + 1;
ln= length(n);
m=  round(f/df)';   % f to m
lm= length(m);      % number of points on f-axis 
m0= mod(m, N) + 1;
x1= [zeros(Q, 1);x.'; zeros(Q, 1)];
gs= exp(-sgm*pi*dtau^2*[Q:-1:-Q]'.^2) * dtau;
y= zeros(lm, ln);
 
%常數在loop外做以提高效率
m1= 1j*2*pi/N*m;
Q2= 2*Q;
sgm1= sgm^(0.25);
for a=1:ln
    x1a= fft(x1(S*n1(a):Q2+S*n1(a)).*gs, N);
    y(1:lm, a)= sgm1*x1a(m0).*exp(m1*(Q-S*n(a)));
end
