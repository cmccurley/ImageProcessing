function [] = plotMask(image, mask)

%{ 
%%***********************************************************************
%    *  File:  plotMask.m
%    *  Name:  Connor McCurley
%    *  Date:  11/2/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Plots an image with its corresponding boundary mask
%    *  Input: MxN image and MxN binary mask image
%    * Output: null
%%**********************************************************************
%} 

imageSize = size(image);
maskImage = image;

imageChannels = {image(:,:,1), image(:,:,2), image(:,:,3)};

for channel = 1:length(imageChannels)
    tempImage = imageChannels{channel};
    tempImage(find(mask)) = 255;
    maskImage(:,:,channel) = tempImage;
end

figure();
imagesc(maskImage);
title('Image with Boundary Mask');

end