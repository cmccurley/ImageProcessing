function [pcImages] = pseudoColor(iImages)

%{ 
%%***********************************************************************
%    *  File:  pseudoColor.m
%    *  Name:  Connor McCurley
%    *  Date:  10/11/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  This function takes in a cell of images and returns their
%              8-value pseudo-color images
%    *  Input: image - cell list of MxN uint8 images
%    * Output: pcImages - cell list of MxN uint8 pseudo-color images
%%**********************************************************************
%} 

pcImages = {};

%define discrete colors
colorNames = ['Black','Brown','Purple','Orange','Yellow','Green','Blue','Red'];
colors = [0 0 0; 139,69,19;255,0,255;255,165,0;255,255,0;0,255,0;0,0,255;255,0,0];
colors = colors./255;

%plot intensity images
for image = 1:size(iImages,2)
figure();
colormap(gray);
imagesc(iImages{image});
title('8-bit Intensity Image');
end

%bin intensity values
numBins = 8;
maxVal = (2^numBins)-1;
numLevelsperBin = (maxVal+1)/numBins;

%Make a look-up table of intensity values
levels = 0:(2^8)-1;
levels = reshape(levels,[numLevelsperBin, numBins]);
levels = levels';

% find which of the 8 rows the current value falls into and assign color
% label to each pixel
for image = 1:size(iImages,2)
    thisImage = iImages{image};
    pcImage = zeros(size(thisImage,1),size(thisImage,2));
    for row = 1:size(thisImage,1)
        for col = 1:size(thisImage,2)
            [levelRow, ~] = find(levels == thisImage(row,col));
            pcImage(row,col) = levelRow;
        end
    end
    pcImages{image} = pcImage;
end

%plot each binned image
for image = 1:size(pcImages,2)
    figure();
    colormap(colors);
    imagesc(pcImages{image});
    title('Pseudo-Color Image');
    cmap = colormap(colors(numBins)); 
    cbh = colorbar; 
    cbh.Ticks = linspace(0, 1, numBins);  
end

end