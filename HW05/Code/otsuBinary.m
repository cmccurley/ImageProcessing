function [segmentedImage] = otsuBinary(image)

%{ 
%%***********************************************************************
%    *  File:  otsuBinary.m
%    *  Name:  Connor McCurley
%    *  Date:  10/31/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Takes an 8 bit intensity which can be segmented with 3
%              intensity levels and performs Otsu's algorithm to extract
%              the foreground.
%    *  Input: image - MxN 8 bit intensity image
%    * Output: segmentedImage - MxN binary image with foreground extracted
%%**********************************************************************
%} 
nBins = 256;
nClasses = 3;

%Show original image
figure();
colormap(gray);
imagesc(image);
title('Image to be Segmented');

%apply smoothing on each channel
image = imgaussfilt(image,1.5);
figure();
colormap(gray);
imagesc(image);
title('Image after Gaussian Smoothing');

%calculate normalized histograms of edge pixels
hist = myhist(image, 'Smoothed Image');
hists = {hist};
images = {image};

%perform Otsu's method to find two threshold values
for im = 1:length(hists)
    
    %get current histogram
    iHist = hists{im};
    
    %get current image
    I = images{im};
    
    %initialize variables
    cumSum1 = 0;
    cumSum2 = 0;
    cumSum3 = 0;
    cumMean1 = 0;
    cumMean2 = 0;
    cumMean3 = 0;
    globalMean = 0;
    globalVar = 0;
    bcVarMax = 0;
    k1Opt = 2;
    k2Opt = 3;
    
    
    %find the global mean (eqt 10-54)
    for k = 1:nBins
       globalMean = globalMean + (iHist(k)*(k-1)); 
    end
    
    %calculate the global variance (eqt 10-58)
    for k = 1:nBins
       globalVar = globalVar + (((k-1) - globalMean)^2)*iHist(k); 
    end
    
    %iterate over all possible threshold values and find set which gives 
    %the maximum between class variance
    for k1 = 2:nBins-1
        for k2 = (k1+1):nBins-1
            %Compute cumulative sum (eqt 10-71)
            cumSum1 = sum(iHist(1:k1));
            cumSum2 = sum(iHist(k1+1:k2));
            cumSum3 = sum(iHist(k2+1:nBins));

            %Compute cumulative means (eqt 10-72)
            cumMean1 = 0;
            cumMean2 = 0;
            cumMean3 = 0;
            for k = 1:k1
               cumMean1 = cumMean1 + (iHist(k)*(k-1)); 
            end
            for k = k1+1:k2
               cumMean2 = cumMean2 + (iHist(k)*(k-1)); 
            end
            for k = k2+1:nBins
               cumMean3 = cumMean3 + (iHist(k)*(k-1)); 
            end
            
            %Calculate the between class variance (eqt 10-70)
            bcVar = cumSum1*(cumMean1-globalMean)^2 + cumSum2*(cumMean2-globalMean)^2 + cumSum3*(cumMean3-globalMean)^2;
            
            %Update max between class variance and optimal thresholds
            if (bcVar > bcVarMax)
               bcVarMax = bcVar;
               k1Opt = k1;
               k2Opt = k2;
            end
        end
    end
    
    %plot histogram with corresponding decision boundaries
    figure();
    bar(1:nBins,iHist,'b'); hold on;
    bar(k1Opt,max(iHist)/2,'r'); hold on;
    bar(k2Opt, max(iHist)/2,'g');
    xlabel('Intensity');
    ylabel('Normalized Frequency');
    title('Normalized Histogram with Decision Boundaries');
end

%Extract foreground using the largest threshold value
segmentedImage = image;
for row = 1:size(image,1)
    for col = 1:size(image,2)
        if segmentedImage(row,col) > k2Opt+3
            segmentedImage(row,col) = 1;
        else
            segmentedImage(row,col) = 0;
        end
    end
end

%plot thresholded images
figure();
colormap(gray);
imagesc(segmentedImage);
title('Image Segmented using Multi-threshold Otsu');

end