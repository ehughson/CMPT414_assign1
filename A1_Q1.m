% Write your own code to linearly stretch the gray scale on "dark.tif"
% so that the image will have a better contrast than in the original image.

%the linear stretching formula is OUTVAL = (INVAL-
%INLO)*((OUTUP-OUTLO)/(INUP- INLO))+ OUTLO
%inval = value of pixel in input map; inlo = lower value of stretch from
%range; inup = upper value of stretch from range; outlo = lower value of
%stretch to range; upper value of stretch to range. 

%references: https://linuxconfig.org/image-processing-linear-stretch-and-opencv

function contrast = assignmentpart4b(I,lp,up)
im  = imread(I);

[rows, cols, color] =  size(im);
if(color >1)
    im = rgb2gray(im);
end
im2 = im; 

%[rows, cols] = size(im);

totnum = rows * cols; 

lower_percentile = lp;
upper_percentile = up;
five_perc = totnum * lower_percentile; 
ninefifth_perc = totnum * upper_percentile; 
 
low_val= 0; 
up_val = 0; 

count = 0;

counts = zeros(1, 256); 

for columns = 1 : cols
    for row = 1 : rows
        grayLevel = im(row, columns);
        counts(grayLevel) = counts(grayLevel) + 1; 
    end
end

tally = 1; 
%disp(counts(1));

for i = 1 : 256
    if tally > five_perc
        low_val = i;
        k = counts(i);
        break;
    else
        tally = tally + counts(i);
    end
end

tally = 0;
for i = 1 : 256
    if tally > ninefifth_perc
        up_val = i;
        k = counts(i);
        break;
    else
        tally = tally + counts(i);
    end
end         
          
            
grayLevels = 0 : 255; 
bar(grayLevels, counts, 'BarWidth', 1, 'FaceColor', 'b');
xlabel('Gray Level', 'FontSize', 20); 
ylabel('Pixel Count', 'FontSize', 20); 
title('Histogram', 'FontSize', 20); 
grid on;


%FIND OUT HOW TO GET 5 PERCENTILE FROM HISTOGRAM AND 95TH PERCENTILE FROM
%HISTOGRAM


disp(up_val); 
disp(low_val); 
for i = 1:size(im, 1)
   for j = 1:size(im, 2)
       f = im(i, j);
       if f < low_val
           im(i,j) = 0;
       end
       if f > up_val
           im(i,j) = 255;
       end
       if f>= low_val && f <= up_val
           im(i,j) = (255/(up_val- low_val))*(f - low_val);
       end
   end
end

figure;
imshow(im);



%Part b of question #1: Try histogram equalization for the same image.


eq_image = histeq(im2);

figure;
imshow(eq_image); 
end