function y=wavelet8D_iwavelet8D(x)
g=[-0.0106  0.0329  0.0308 -0.1870 -0.0280  0.6309  0.7148  0.2304];
h=[ 0.2304 -0.7148  0.6309  0.0280 -0.1870 -0.0308  0.0329  0.0106];
g1=[0.2304  0.7148  0.6309 -0.0280 -0.1870  0.0308  0.0329 -0.0106];
h1=[0.0106  0.0329 -0.0308 -0.1870  0.0280  0.6309 -0.7148  0.2304];
 
%wavelet8D===================================================
 
%first compression
for m=1:size(x,1)
    x_along_n = x(m,1:2:size(x,2));
    v_1L(m,:) = conv(x_along_n,g);
    v_1H(m,:) = conv(x_along_n,h);
end
 
%second compression
for n=1:size(v_1L,2)
    x_along_m1 = v_1L(1:2:size(v_1L,1),n);
    x_1L(:,n) = conv(x_along_m1,g);
    x_H1(:,n) = conv(x_along_m1,h);
end
 
for n=1:size(v_1H,2)
    x_along_m2 = v_1H(1:2:size(v_1H,1),n);
    x_H2(:,n) = conv(x_along_m2,g);
    x_H3(:,n) = conv(x_along_m2,h);
end 
 
%show Lena wavelet photo
y_wavelet=[x_1L(:,:),x_H1(:,:);x_H2(:,:),x_H3(:,:)];
y_wavelet=uint8(y_wavelet);
imwrite(y_wavelet,'Lena_wavelet.bmp','BMP');
x_wavelet=imread('Lena_wavelet.bmp');
figure;
imshow(x_wavelet);
title('Lena wavelet','Fontsize',12);
 
%iwavelet8D==================================================
 
%first reconstruction
for m=1:2*size(x_1L,1)
    for n=1:size(x_1L,2)
        if mod(m,2)==1
            x_along_m1_r(m,n) = 0;
        else
            x_along_m1_r(m,n) = x_1L(m/2,n);  
        end
    end
end
for m=1:2*size(x_1L,1)
    x_1L_r(m,:) = conv(x_along_m1_r(m,:),g1);
    x_H1_r(m,:) = conv(x_along_m1_r(m,:),h1);
end
v_1L_r=x_1L_r+x_H1_r;
 
for m=1:2*size(x_H2,1)
    for n=1:size(x_H2,2)
        if mod(m,2)==1
            x_along_m2_r(m,n) = 0;
        else
            x_along_m2_r(m,n) = x_H2(m/2,n);  
        end
    end
end
for m=1:2*size(x_H2,1)
    x_H2_r(m,:) = conv(x_along_m2_r(m,:),g1);
    x_H3_r(m,:) = conv(x_along_m2_r(m,:),h1);
end
v_1H_r=x_H2_r+x_H3_r;
 
%second reconstruction
for n=1:2*size(v_1L_r,2)
    for m=1:size(v_1L_r,1)
        if mod(n,2)==1
            x_along_n1_r(m,n) = 0;
        else
            x_along_n1_r(m,n) = v_1L_r(m,n/2);  
        end
    end
end
for n=1:2*size(v_1L_r,2)
    x_r1(:,n) = conv(x_along_n1_r(:,n),g1);
end
 
for n=1:2*size(v_1H_r,2)
    for m=1:size(v_1H_r,1)
        if mod(n,2)==1
            x_along_n2_r(m,n) = 0;
        else
            x_along_n2_r(m,n) = v_1H_r(m,n/2); 
        end
    end
end
for n=1:2*size(v_1H_r,2)
    x_r2(:,n) = conv(x_along_n2_r(:,n),h1);
end
 
%remove border parts
y_r=x_r1+x_r2;
for m=1:size(y_r,1)-28
    for n=1:size(y_r,2)-28
        y(m,n)=y_r(m+14,n+14);
    end
end
 
end
