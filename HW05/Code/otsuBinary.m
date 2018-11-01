function [image] = otsuBinary(image)

%{ 
%%***********************************************************************
%    *  File:  otsuBinary.m
%    *  Name:  Connor McCurley
%    *  Date:  10/31/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  
%    *  Input: 
%    * Output: 
%%**********************************************************************
%} 
nBins = 256;

%Show original image
figure();
imagesc(image);
colormap(gray);
title('Scene to be Segmented');

%calculate normalized histograms
hist = myhist(image);

%perform Otsu's method for foreground extraction
    
%initialize variables
cumSum = zeros(nBins,1);
cumMean = zeros(nBins,1);
bcVar = zeros(nBins,1);
globalMean = 0;
globalVar = 0;
eta = 0;

for ind = 1:nBins
    %Compute cumulative sum (eqt 10-49)
    cumSum(ind) = sum(hist(1:ind));

    %Compute cumulative means (eqt 10-53)
    for k = 1:ind
       cumMean(ind) = cumMean(ind) + (hist(k)*(k-1)); 
    end
end

%find the global mean (eqt 10-54)
for k = 1:nBins
   globalMean = globalMean + (hist(k)*(k-1)); 
end

%calculate between-class variances (eqt 10-62)
for ind = 1:nBins
    bcVar(ind) = ((globalMean*cumSum(ind)-cumMean(ind))^2)/(cumSum(ind)*(1-cumSum(ind)));
end

%find optimal threshold value for which bcVar is maximized
[val, thresh] = max(bcVar);
thresh = thresh - 1;

%calculate the global variance (eqt 10-58)
for k = 1:nBins
   globalVar = globalVar + (((k-1) - globalMean)^2)*hist(k); 
end

%compute the separability measure (eqt 10-61)
eta = bcVar(thresh)/globalVar;

%threshold image
for row = 1:size(image,1)
    for col = 1:size(image,2)
        if image(row,col) > thresh
           image(row,col) = 1;
        else
           image(row,col) = 0; 
        end
    end
end
    
%plot thresholded images
figure();
colormap(gray);
imagesc(image);
title('Thresholded Image using Otsu');


end