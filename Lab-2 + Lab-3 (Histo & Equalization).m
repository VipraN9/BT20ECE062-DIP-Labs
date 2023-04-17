clc;
clear all;
close all;

I = [52	55	61	59	79	61	76	61
     62	59	55	104	94	85	59	71
     63	65	66	113	144	104	63	72
     64	70	70	126	154	109	71	69
     67	73	68	106	122	88	68	68
     68	79	60	70	77	66	58	75
     69	85	64	58	55	61	65	83
     70	87	69	68	65	73	78	90];
 
 I = uint8(I);

 [row,col,depth] = size(I);

if depth ==3
    I = rgb2gray(I);
end

I = double(I);

HistIn = zeros(1,256);
for i = 1:row
    for j = 1:col
        for k1 = 0:255
            if I(i,j)==k1
                HistIn(k1+1)= HistIn(k1+1)+1;
            end
        end
    end
end

% Lab-3 : Histogram Equalization

HistIn_norm = (1/(row*col))*HistIn;

HistIn_cdf = zeros(1,256);
HistIn_cdf(1)= HistIn_norm(1);
for i=2:256
    HistIn_cdf(i)=HistIn_cdf(i-1)+HistIn_norm(i);
end

HistIn_cdf = round(255*HistIn_cdf);

Ih = zeros(row,col);
for i=1:row
    for j=1:col
        pix = (I(i,j)+1);
        Ih(i,j)= HistIn_cdf(pix);
    end
end

HistOut = zeros(1,256);
for i =1:row
    for j=1:col
        for k=0:255
            if Ih(i,j) ==k
                HistOut(k+1)= HistOut(k+1)+1;
            end
        end
    end
end

% Plots

subplot(2,2,1);
imshow(uint8(I));
title("Input Image");

subplot(2,2,2);
plot(HistIn);
title("Input Images's Histogram");
xlabel("Gray Levels");
ylabel("Frequency");


subplot(2,2,3);
imshow(uint8(Ih));
title("Histogram Equalized Image");

subplot(2,2,4);
plot(HistOut);
title("Output Images's Histogram");
xlabel("Gray Levels");
ylabel("Frequency");
