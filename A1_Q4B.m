%4B
%Write your own to implment the "canny edge operator"

function [mag,theta]  = A1_Q4B(I, sig, filtersize, min_threshold, max_threshold)
I = imread(I);
%I = rgb2gray(I);


%first conduct smoothing using Gaussian smoothing
A = double(I); 
[x, y]= size(A);
Theta = zeros(x,y);
mag = zeros(x,y);

sigma = sig; 
sz = filtersize; 
[x, y] = meshgrid(-sz:sz, -sz:sz);

M = size(x, 1)-1;


Exp_comp = -(x.^2 + y.^2)/(2*sigma*sigma);
Kernel = exp(Exp_comp)/(2*pi*sigma*sigma);
%disp(Kernel);

newA = A;
[x2,y2] = size(A);
for i = 1:x2-M
    for j = 1:y2-M
        K = A(i:i+M, j:j+M);
        %disp(K);
        Temp = K.*Kernel;
        newA(i, j) = sum(Temp(:));
        %disp(newA(i,j));
    end
end

%reference https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_canny/py_canny.html
%Next find magnitude and direction using a gradient operation
%dy = newA(:, 2:end) - newA(:, 1:end-1);
%dx = newA(2:end, :) - newA(1:end-1, :);
[r, c] = size(newA);


sobel_filter = fspecial('sobel');   
dy = imfilter(newA, sobel_filter, 'conv');
dx = imfilter(newA, sobel_filter', 'conv');

for i=1:r-1
    for j=1:c-1
        Theta(i,j) = atand(dy(i,j) ./ dx(i,j));
        mag(i,j) = sqrt((dy(i,j).^2) + (dx(i,j).^2));
    end
end

round = size(Theta);

for i = 1:r-1
    for j = 1:c-1
        %for degree of 0 and 180 or '-' 
        if ((Theta(i,j) < 23 && Theta(i,j) >= -21 )|| Theta(i,j) >= 158 && Theta(i,j) < -156)
            round(i,j) = 0;
        end
        %for degree of 45 and 225 or '/'
        if ((Theta(i,j) < 68 && Theta(i,j) >= 23) || (Theta(i,j) >= -156 && Theta(i,j) < -111))
            round(i,j) = 45;
        end
        %for degree of 90 and 270 or '|'
        if((Theta(i,j) >= 68 && Theta(i,j) < 112) || (Theta(i,j) > -110 && Theta(i,j) <= -68))
            round(i,j) = 90; 
        end
        %for degree of 135 and 315 or '\'
        if((Theta(i,j) >= 113 && Theta(i,j) < 158) || (Theta(i,j) < -21 && Theta(i,j) >= -68))
            round(i,j) = 135;
        end
    end
end


[r, c] = size(round);
%Conduct non-maximal supression

%reference: https://www.oreilly.com/library/view/hands-on-image-processing/9781789343731/75afc2d9-fb80-4de1-85f2-dba0750d3883.xhtml
%reference: https://opencv-python-tutroals.readthedocs.io/en/latest/py_tutorials/py_imgproc/py_canny/py_canny.html
for i = 2:r-1
    for j = 2:c-1
       if(round(i,j) == 0)
           if(mag(i-1,j) > mag(i,j) || mag(i+1,j) > mag(i,j))
               mag(i,j) = 0;
           end
       end
        if(round(i,j) == 90)
           if(mag(i,j-1) > mag(i,j) || mag(i,j+1) > mag(i,j))
               mag(i,j) = 0;
           end
        end
        if(round(i,j) == 45)
           if(mag(i+1,j+1) > mag(i,j) || mag(i-1,j-1) > mag(i,j))
               mag(i,j) = 0;
           end
        end
        if(round(i,j) == 135)
           if(mag(i+1,j-1) > mag(i,j) || mag(i-1,j+1) > mag(i,j))
               mag(i,j) = 0;
           end
       end
       
    end
end


%max_threshold = 9;
%min_threshold = 1;

%reference: https://www.reddit.com/r/computervision/comments/78zm9o/canny_edge_detector_image_hysteresis_thresholding/doyioyq/
%conduct hysteresis
for i = 2:r
    for j = 2:c
        if(mag(i,j) < min_threshold)
            mag(i,j) = 0; 
        end
        if(mag(i,j) <= max_threshold || mag(i,j) >= min_threshold)
            if(mag(i-1,j) > max_threshold || mag(i+1,j) > max_threshold || mag(i+1, j+1) > max_threshold || mag(i, j+1) > max_threshold || mag(i, j-1) > max_threshold || mag(i-1,j-1) > max_threshold)
                mag(i,j) = 1; 
            else
                mag(i,j) = 0;
            end
            
        end
    end
end

imshow(mag);

end


