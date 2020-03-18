%for this section i need to create a foorloop to try for various values in
%imgaussfilt and median for all of the images

function smoothing = A1_Q2(I)
I = imread(I);
j = 0;
for i = 1:2:15   
    j= j+1;
    Iblur1 = imgaussfilt(I,'FilterSize',i);
    %Iblur1 = imgaussfilt(I,i); this is for adjusting sigma instead of
    %filtersize
    figure(j);
    imshow(Iblur1);
end

for m = 1:5  
    for n = 1:5
        Imed1 = medfilt2(I,[m n]);
        figure(m+5);
        imshow( Imed1);
    end
end

i = 0; 
for n = 3:2:11
     IB = imboxfilt(I, n);
     i = i+1; 
 	 figure(i +10);
     imshow( IB);
end


figure 
imshow(I)
title('Original Image')

figure
imshow(Iblur1)
title('Gaussian Filter')

figure
imshow(Imed1)
title('median image')

figure
imshow(IB);
title('normalized box filter');
end