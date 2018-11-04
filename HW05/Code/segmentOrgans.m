function [ccImage] = segmentOrgans(image,gt)

%{ 
%%***********************************************************************
%    *  File:  segmentOrgans.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Finds the boundary between foreground and background
%    *  Input: image - single channel binary image 
%    *  Output: boundImage -  single channel binary image of boundary mask
%%**********************************************************************
%} 


%perform morphological opening to "clean" image (erosion then dilation)
seOpen = strel('disk',12);
openedImage = erodeImage(image, seOpen.Neighborhood);
openedImage = dilateImage(openedImage, seOpen.Neighborhood);
figure();
colormap(gray);
imagesc(openedImage);
title('Image after Opening')

%find the connected components
seCC = ones(3,3);
ccImage = connectedComp(openedImage, seCC, gt);

end