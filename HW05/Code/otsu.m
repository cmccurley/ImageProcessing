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

%separate color channels
redImage = image(:,:,1);
blueImage = image(:,:,2);
greenImage = image(:,:,3);

%Show corrupted image
figure();
imagesc(image);
title('Scene to be Segmented');

%calculate normalized histograms
rHist = myhist(redImage, 'Red Channel');
bHist = myhist(blueImage, 'Blue Channel');
gHist = myhist(greenImage, 'Green Channel');

end