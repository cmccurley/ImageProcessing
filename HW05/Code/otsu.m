function [threshImage] = otsu(image)

%{ 
%%***********************************************************************
%    *  File:  otsu.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  
%    *  Input: 
%    * Output: 
%%**********************************************************************
%} 
nBins = 256;

%separate color channels
redImage = image(:,:,1);
blueImage = image(:,:,2);
greenImage = image(:,:,3);

%Show original image
figure();
imagesc(image);
title('Scene to be Segmented');

%calculate normalized histograms
rHist = myhist(redImage, 'Red Channel');
bHist = myhist(blueImage, 'Blue Channel');
gHist = myhist(greenImage, 'Green Channel');

hists = {rHist, bHist, gHist};
images = {redImage, blueImage, greenImage};

binaryImages = {};

%perform Otsu's method for each of the color channel histograms
for im = 1:length(hists)
    
    %get current histogram
    iHist = hists{im};
    
    %get current image
    I = images{im};
    
    %initialize variables
    cumSum = zeros(nBins,1);
    cumMean = zeros(nBins,1);
    bcVar = zeros(nBins,1);
    globalMean = 0;
    globalVar = 0;
    eta = 0;
    
    for ind = 1:nBins
        %Compute cumulative sum (eqt 10-49)
        cumSum(ind) = sum(iHist(1:ind));
        
        %Compute cumulative means (eqt 10-53)
        for k = 1:ind
           cumMean(ind) = cumMean(ind) + (iHist(k)*(k-1)); 
        end
    end
    
    %find the global mean (eqt 10-54)
    for k = 1:nBins
       globalMean = globalMean + (iHist(k)*(k-1)); 
    end
    
    %calculate between-class variances (eqt 10-62)
    for ind = 1:nBins
        bcVar(ind) = ((globalMean*cumSum(ind)-cumMean(ind))^2)/(cumSum(ind)*(1-cumSum(ind)));
    end
    
    %find optimal threshold value for which bcVar is maximized
    [val, thresh] = max(bcVar);
    
    %calculate the global variance (eqt 10-58)
    for k = 1:nBins
       globalVar = globalVar + (((k-1) - globalMean)^2)*iHist(k); 
    end
    
    %compute the separability measure (eqt 10-61)
    eta = bcVar(thresh)/globalVar;
    
    %threshold image
    for row = 1:size(I,1)
        for col = 1:size(I,2)
            if I(row,col) > thresh
               I(row,col) = 1;
            else
               I(row,col) = 0; 
            end
        end
    end
    
    binaryImages{im} = I;
    
end

%plot thresholded images
figure();
colormap(gray);
imagesc(binaryImages{1});
title('Red Channel Thresholded Image using Otsu');

figure();
colormap(gray)
imagesc(binaryImages{2});
title('Blue Channel Thresholded Image using Otsu');

figure();
colormap(gray)
imagesc(binaryImages{3});
title('Green Channel Thresholded Image using Otsu');

threshImage = zeros(size(binaryImages{1},1),size(binaryImages{1},2),3);
for n = 1:length(binaryImages)
   threshImage(:,:,n) = binaryImages{n}; 
end
end