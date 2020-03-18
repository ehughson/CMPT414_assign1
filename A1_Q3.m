
function sharpen = A1_Q3(I)

I = imread(I);


%an attempt to conduct Gaussian High pass filter -- standard unsharp filter
sharpened = imsharpen(I, 'Radius',4,'Amount',2);
figure;
imshow(sharpened);

%using simple sharpening mask
kernel = [0, -1, 0; -1, 5, -1; 0, -1, 0];
sharpenedImage = imfilter(I, kernel);
figure;
imshow(sharpenedImage);

%using laplacian of gaussian filters to conduct unsharpening
kernel = [-1, -1, -1; -1, 8, -1; -1, -1,-1];
sharpenedImage = imfilter(I, kernel);
sharpenedImage = I - sharpenedImage;
figure;
imshow(sharpenedImage);


red = I(:,:,1);
green = I(:,:,2);
blue = I(:,:,3);

%imsharpen conducts unsharpening
newRed = imsharpen(red, 'Radius',2,'Amount',2.5);
newGreen = imsharpen(green, 'Radius',2,'Amount',2.5);
newBlue = imsharpen(blue, 'Radius',2,'Amount',2.5);

kernel = [0, -1, 0; -1, 5, -1; 0, -1, 0];
newRed2 = imfilter(red, kernel);
kernel = [0, -1, 0; -1, 5, -1; 0, -1, 0];
newGreen2 = imfilter(green, kernel);
kernel = [0, -1, 0; -1, 5, -1; 0, -1, 0];
newBlue2 = imfilter(blue, kernel);

rgbImage = cat(3, newRed ,newGreen, newBlue);
figure;
imshow(rgbImage);
title('RGB Sharpened Image')
rgbImage2 = cat(3, newRed2 ,newGreen2, newBlue2);
figure;
imshow(rgbImage2);

%Y = 0.299*red + 0.587*green +0.114*blue;

ycbcr = rgb2ycbcr(I);
Y = ycbcr(:,:,1);
U = ycbcr(:,:,2);
V = ycbcr(:,:,3);

newY = imsharpen(Y, 'Radius',2,'Amount',2);

kernel = [0, -1, 0; -1, 5, -1; 0, -1, 0];
newY2 = imfilter(Y, kernel);


rgbImage = cat(3, newY ,U, V);
rgbImage2 = cat(3, newY2 ,U, V);

rgbmap = ycbcr2rgb(rgbImage);
rgbmap2 = ycbcr2rgb(rgbImage2);


figure;
imshow(rgbmap);

figure;
imshow(rgbmap2);

%lap = [0 -1 0; -1 5 -1; 0 -1 0];


%figure
%imshow(B)
%title('Sharpened Image');
end