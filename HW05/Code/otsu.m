function [threshImage] = otsu(image)

%{ 
%%***********************************************************************
%    *  File:  otsu.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Performs Otsu's methods for foreground extraction on an
%              rgb image after smoothing with a Gaussian filter and 
%              edge detection with a sobel filter.
%    *  Input: image - 3 channel rgb image of size MxN
%    * Output: threshImage - 3 channel binary image of size MxN
%%**********************************************************************
%} 
nBins = 256;

%Show original image
figure();
imagesc(image);
title('Scene to be Segmented');

%separate color channels
redImage = image(:,:,1);
greenImage = image(:,:,2);
blueImage = image(:,:,3);

%apply smoothing on each channel
redImage = imgaussfilt(redImage,2);
greenImage = imgaussfilt(greenImage,2);
blueImage = imgaussfilt(blueImage,2);

%detect edges using sobel filter
redEdges = edge(redImage,'sobel');
greenEdges = edge(greenImage,'sobel');
blueEdges = edge(blueImage,'sobel');

figure();
colormap(gray);
imagesc(redEdges);
title('Sobel Edges in Red Channel');

figure();
colormap(gray)
imagesc(greenEdges);
title('Sobel Edges in Green Channel');

figure();
colormap(gray)
imagesc(blueEdges);
title('Sobel Edges in Blue Channel');

%calculate normalized histograms of edge pixels
rHist = myhist(redImage(redEdges), 'Red Channel');
gHist = myhist(greenImage(greenEdges), 'Green Channel');
bHist = myhist(blueImage(blueEdges), 'Blue Channel');

hists = {rHist, gHist, bHist};
images = {redImage, greenImage, blueImage};

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
    thresh = thresh - 1;
    
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
title('Green Channel Thresholded Image using Otsu');

figure();
colormap(gray)
imagesc(binaryImages{3});
title('Blue Channel Thresholded Image using Otsu');

%reshape output image into 3 channel binary image
threshImage = zeros(size(binaryImages{1},1),size(binaryImages{1},2),3);
for n = 1:length(binaryImages)
   threshImage(:,:,n) = binaryImages{n}; 
end
end