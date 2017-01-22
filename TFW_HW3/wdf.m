function y = wdf(x,t,f)%by R04943133

%建立參數
dt = t(2)-t(1);
df = f(2)-f(1);
N = fix(1/(2*dt*df));
n0 = t(1);
m0 = f(1);
n1 = length(x);
m = fix(f/df);
n = fix(t/df);

%DFT method
for i = 1:n1
    Q = min(n1-i,i-1);
    C = x(i-Q:i+Q).*conj(x(i+Q:-1:i-Q));
    X = fft(C,N);
    y(:,i)=2*dt*exp(j*2*pi*m*Q/N).*X(mod(m,N)+1);
    
end

