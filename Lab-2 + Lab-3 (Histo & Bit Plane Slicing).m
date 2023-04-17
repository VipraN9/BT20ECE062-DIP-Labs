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

%Histogram Equalization

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc; 
clear; 
close all;

I = imread('map.png');
Ig = rgb2gray(I);

[row, col, layers] = size(Ig);
if (layers==3)
    error('Input Image should be a Greyscale Image in order to perform Bit Plane Slicing');
else
    [B1,B2,B3,B4,B5,B6,B7,B8] = BitPlaneSlicing(Ig);
end

%Bit Plane 1(LSB)
subplot(3,3,1);
imshow(B1);
title('I0(LSB)');

%Bit Plane 2
subplot(3,3,2);
imshow(B2);
title('I1');

%Bit Plane 3
subplot(3,3,3);
imshow(B3);
title('I2');

%Bit Plane 4
subplot(3,3,4);
imshow(B4);
title('I3');

%Bit Plane 5
subplot(3,3,5);
imshow(B5);
title('I4');

%Bit Plane 6
subplot(3,3,6);
imshow(B6);
title('I5');

%Bit Plane 7
subplot(3,3,7);
imshow(B7);
title('I6');

%Bit Plane 8(MSB)
subplot(3,3,8);
imshow(B8);
title('I7(MSB)');
 
% Task - 1.2
B1 = zeros(row,col);
Recombined_Planes = B1*(2^0) + B2*(2^1) + B3*(2^2) + B4*(2^3) + B5*(2^4) + B6*(2^5) + B7*(2^6) + B8*(2^7);
Ir = uint8(Recombined_Planes);
subplot(3,3,9);
imshow(Ir);
title('Reconstructed Image');
 
% Bit Plane Slicer (Function) using bitget command
function [B1, B2, B3, B4, B5, B6, B7, B8] = BitPlaneSlicing(Ig)
[row, col] = size(Ig);
B=zeros(row,col,8);
for k = 1:8
    for i = 1:row
        for j = 1:col
            B(i,j,k) = bitget(Ig(i,j),k); % Extracting Kth Bit of Each Pixel(i,j)of Ig
                                          % and storing Extracted Kth bit in I(k-1) Matrix 
        end
    end
end

B1 = B(:,:,1);
B2 = B(:,:,2);
B3 = B(:,:,3);
B4 = B(:,:,4);
B5 = B(:,:,5);
B6 = B(:,:,6);
B7 = B(:,:,7);
B8 = B(:,:,8);
end
