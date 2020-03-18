%4a
%Try at least three different edge operators on one of the noisy images and one of the smoothed images

function gradient_operators = A1_Q4A(I)

I = imread(I);
%I2 = imread('gaussfiltiteration2.png');

H = fspecial('prewitt');
prewitt = imfilter(I,H,'replicate');
figure;
imshow(prewitt);

H = fspecial('sobel');
sobel = imfilter(I,H,'replicate');
figure;
imshow(sobel);


H = fspecial('laplacian',0.4);
lap = imfilter(I,H,'replicate');
figure;
imshow(lap);

end