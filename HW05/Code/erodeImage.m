function [erodedImage] = erodeImage(image, se)

%{ 
%%***********************************************************************
%    *  File:  erodeImage.m
%    *  Name:  Connor McCurley
%    *  Date:  10/31/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  
%    *  Input: 
%    * Output: 
%%**********************************************************************
%} 

seSize = size(se,1);

[imageSize.row, imageSize.col] = size(image);

%apply ones padding to the image
padSize = floor(seSize/2); %number of rows/columns to pad with
paddedImage = padarray(image,[padSize padSize],1); %ones pad original image
[padImSize.row,padImSize.col] = size(paddedImage); %get size of padded image
erodedImage = zeros(imageSize.row,imageSize.col);

%Erode image with structuring element.  Keep edge values the same.

%separate matrix into patches of size seSize by seSize
ind = 1;    
imagePatch = zeros(seSize,seSize,imageSize.row*imageSize.col);
for patchRow = 1:(padImSize.row-seSize+1)
    for patchCol = 1:(padImSize.col-seSize+1)
        imagePatch(:,:,ind) = paddedImage(patchRow:(patchRow+seSize-1),patchCol:((patchCol+seSize-1))); 
        ind = ind+1;
    end
end
         
%verify if element is fully conatained in region
for pixel = 1:size(imagePatch,3)
    windowSum = sum(imagePatch(:,:,pixel).*se);

    if windowSum == size(se,1)*size(se,2)
        erodedImage(pixel) = 1;
    else
        erodedImage(pixel) = 0;
    end
end 
end

%  %======= reconstruct image from filtered pixel vector =================
%     filteredImage = reshape(filteredImage,imageSize.row,imageSize.col)';
%     filteredImage = uint8(filteredImage);

end