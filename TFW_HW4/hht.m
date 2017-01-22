function y=hht(x_org, t, thr)%by R04943133

%Step1 
%initial
dt=t(2)-t(1);
x=x_org;
 
%threshode n:1~30, k:1~30, 
n=1; n_upper=30;
k=1; k_upper=30;
 
IMF_matrix = zeros(n_upper, length(t));
 
%Step2
for step8=1:n_upper
 
for step7=1:k_upper
clear lmax;    %local maximum for x(i)
clear lmax_sp; %sampling points of local maximum for x(i)
index=1;
for i=1:length(x)
    if (i==1 || i==length(x))
        lmax(index)=0;
        lmax_sp(index)=(i-1)*dt;
        index=index+1;
    elseif( (x(i)>x(i-1)) && (x(i)>x(i+1)) )
        lmax(index)=x(i);
        lmax_sp(index)=(i-1)*dt; 
        index=index+1;
    end
end
 

%boundary lmax(1) & lmax(max)
if(length(lmax)>=10)
    lmax32=lmax(3)-lmax(2);
    lmax_sp32=lmax_sp(3)-lmax_sp(2);
    lmax(1)=lmax(2)-lmax32/lmax_sp32*lmax_sp(2);
    
    lmax_len=length(lmax);
    lmax12=lmax(lmax_len-1)-lmax(lmax_len-2);
    lmax_sp12=lmax_sp(lmax_len-1)-lmax_sp(lmax_len-2);
    lmax(lmax_len)=lmax(lmax_len-1)+lmax12/lmax_sp12*(10-lmax_sp(lmax_len-1));
end
 
%Step3
%local max curve for x(i) => lmaxc
clear lmaxc;
lmaxc=spline(lmax_sp, lmax, t);
 
 
%Step4
clear lmin;    %local minimum for x(i)
clear lmin_sp; %sampling points of local minimum for x(i)
index=1;
for i=1:length(x)
    if (i==1 || i==length(x))
        lmin(index)=0;
        lmin_sp(index)=(i-1)*dt;
        index=index+1;
    elseif( (x(i)<x(i+1)) && (x(i)<x(i-1)) )
        lmin(index)=x(i);
        lmin_sp(index)=(i-1)*dt;
        index=index+1;
    end
end
 



%boundary lmin(1) & lmin(max)
if(length(lmin)>=10)
    lmin32=lmin(3)-lmin(2);
    lmin_sp32=lmin_sp(3)-lmin_sp(2);
    lmin(1)=lmin(2)-lmin32/lmin_sp32*lmin_sp(2);
    
    lmin_len=length(lmin);
    lmin12=lmin(lmin_len-1)-lmin(lmin_len-2);
    lmin_sp12=lmin_sp(lmin_len-1)-lmin_sp(lmin_len-2);
    lmin(lmin_len)=lmin(lmin_len-1)+lmin12/lmin_sp12*(10-lmin_sp(lmin_len-1));
end
 
%Step5
%local minimum curve for x(i) => lminc
clear lminc; 
lminc=spline(lmin_sp, lmin, t);
 
 
%Step6-1
for i=1:length(t)
z(i)=(lmaxc(i)+lminc(i))/2;
end
 
%x_z=linspace(0,10,length(z));
 
%Step6-2
for i=1:length(t)
    h(i)=x(i)-z(i);
end
 







%Step7
%Checking h(i)
fail=0;
clear lmax2;     %local maximum for h(i)
clear lmax2_sp;  %sampling points of local maximum for h(i)
index=1;
for i=1:length(x)
    if (i==1 || i==length(x))
        lmax2(index)=0;
        lmax2_sp(index)=i;
        index=index+1;     
    elseif( (h(i)>h(i+1)) && (h(i)>h(i-1)) )
        lmax2(index)=h(i);
        lmax2_sp(index)=i;
        %check whether local maximums > 0 
        if(fail==0 && lmax2(index)<0)
            fail=1;
        end
        index=index+1;
    end
end
 
%boundary lmax2(1) & lmax2(max)
if(length(lmax2)>=10)
    lmax2_32=lmax2(3)-lmax2(2);
    lmax2_sp32=lmax2_sp(3)-lmax2_sp(2);
    lmax2(1)=lmax2(2)-lmax2_32/lmax2_sp32*lmax2_sp(2);
    
    lmax2_len=length(lmax2);
    lmax2_12=lmax2(lmax2_len-1)-lmax2(lmax2_len-2);
    lmax2_sp12=lmax2_sp(lmax2_len-1)-lmax2_sp(lmax2_len-2);
    lmax2(lmax2_len)=lmax2(lmax2_len-1)+lmax2_12/lmax2_sp12*(10-lmax2_sp(lmax2_len-1));
    %check whether local maximums > 0 
    if(fail==0 && (lmax2(1)<0 || lmax2(lmax2_len)<0))
        fail=1;
    end
end
%local maximums curve for h(i) => lmaxc2
clear lmaxc2; 
lmaxc2=spline(lmax2_sp, lmax2, t);
 
clear lmin2;     %local minimum for h(i)
clear lmin2_sp;  %sampling points of local minimum for h(i)
index=1;
for i=1:length(x)
    if (i==1 || i==length(x))
        lmin2(index)=0;
        lmin2_sp(index)=i;
        index=index+1;
    elseif( (h(i)<h(i+1)) && (h(i)<h(i-1)) )
        lmin2(index)=h(i);
        lmin2_sp(index)=i;
        %check whether local minimums < 0 
        if(fail==0 && lmin2(index)>0)
            fail=1;
        end
        index=index+1;
    end
end
 
%boundary lmin2(1) & lmin2(max)
if(length(lmin)>=10)
    lmin2_32=lmin2(3)-lmin2(2);
    lmin2_sp32=lmin2_sp(3)-lmin2_sp(2);
    lmin2(1)=lmin2(2)-lmin2_32/lmin2_sp32*lmin2_sp(2);
    
    lmin2_len=length(lmin2);
    lmin2_12=lmin2(lmin2_len-1)-lmin2(lmin2_len-2);
    lmin2_sp12=lmin2_sp(lmin2_len-1)-lmin2_sp(lmin2_len-2);
    lmin2(lmin2_len)=lmin2(lmin2_len-1)+lmin2_12/lmin2_sp12*(10-lmin2_sp(lmin2_len-1));
    %check whether local minimums < 0 
    if(fail==0 && (lmin2(1)>0 || lmin2(lmin2_len)>0))
        fail=1;
    end
end
 
%local minimums curve for h(i) => lminc2
clear lminc2; 
lminc2=spline(lmax2_sp, lmax2, t);
 
%check whether means < threshold
for i=1:length(t)
    mean(i)=(lmaxc2(i)+lminc2(i))/2;
    if( fail==0 && abs(mean(i))>thr )
        fail=1;
        break;
    end
end
 
%check fail status
IMF_matrix(n,:)=h;
if(fail==0) 
   k=1;
   break; 
else
    x=h;
    k=k+1;
end
 
%Step7 end
end
 
%Step8
c_sum=zeros(1,length(t));
for j=1:length(t)
    for i=1:n
        c_sum(j)=IMF_matrix(i,j)+c_sum(j);
    end   
end
x0=x_org-c_sum;
 

%local maximum 
entry1=0;
for i=2:length(x0)-1
    if( (x0(i)>x0(i+1)) && (x0(i)>x0(i-1)) )
        entry1=entry1+1;
    end
end
 
%local minimum
entry2=0;
for i=2:length(x0)-1
   if( (x0(i)<x0(i+1)) && (x0(i)<x0(i-1)) )
        entry2=entry2+1;
   end
end
 
%the number of non-boundary extremes can be no more than 3
if( entry1+entry2 <= 3)
   break;
else
    n=n+1;
    x=x0;
end
 
%Step8 end
end
 
%Show each IMF of x(t)
for i=1:n
    figure; 
    plot(t,IMF_matrix(i,:));
    title('IMF','Fontsize',12);
    xlabel('t (Sec)','Fontsize',12) ; 
    ylabel(['IMF' num2str(i) ],'Fontsize',12); 
    axis([-inf,inf,-2.3,2.3]);
end   
 
y=x0;
