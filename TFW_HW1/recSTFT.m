function y =recSTFT(x,t,f,B)%r04943133 implement by fft based
t_l = length(t);
f_l = length(f);
dt = (max(t) - min(t)) / (t_l - 1);
df = (max(f) - min(f)) / (f_l - 1);

n0 = min(t)/dt;
n1 = max(t)/dt;
n = n0:1:n1; 

m0 = min(f)/df;
m1 = max(f)/df;
m = m0:1:m1;

N = 1/(dt*df);
Q = round(B/dt);
Q1 = B/dt;
x_tmp = [ zeros(1,Q),x,zeros(1,Q)];
n_var = n(1);
q = 0:1:2*Q;
m_tmp = round(mod(m,N))+1;
X_1 = zeros(t_l,N+1);
X_2 = zeros(t_l,f_l);
y = zeros(t_l,f_l);

tmp=1-n0;
k=[1:1:2*Q+1];
for i = n0:1:n1
    j = i + tmp;
    x_1(j,k) = x_tmp(i + k - (t(1) / dt));
    X_1(j,:) = fft(x_1(i + tmp,:),N + 1);
    X_2(j,:) = X_1(i + tmp,m_tmp);
end
X_2 = X_2';
s = m'*(Q-n);
y = 0.02*exp(j*2*pi*s).*X_2;