function [filteredImage] = myfilt(image,filtType,filtSize)

%{ 
***********************************************************************
    *  File:  myfilt.m
    *  Name:  Connor McCurley
    *  Date:  09/26/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  This script allows 
**********************************************************************
%} 


% %Show image
% figure();
% colormap(gray);
% imagesc(image);
% colorbar;
% title('Noisy Image');

%Throw usage instructions if error
try
    [imageSize.row,imageSize.col] = size(image); %get size of original image
    filteredImage = zeros(imageSize.row*imageSize.col,1); %column vector of filtered pixels
    padSize = floor(filtSize/2); %number of rows/columns to pad with
    paddedImage = padarray(image,[padSize padSize]); %zero pad original image
    [padImSize.row,padImSize.col] = size(paddedImage); %get size of padded image
    
    %separate matrix into patches size of filtSize by filtSize
    ind = 1;
    imagePatch = zeros(filtSize,filtSize,imageSize.row*imageSize.col);
    for row = 1:(padImSize.row-filtSize+1)
        for col = 1:(padImSize.col-filtSize+1)
            imagePatch(:,:,ind) = paddedImage(row:(row+filtSize-1),col:((col+filtSize-1))); 
            ind = ind+1;
        end
    end
    
    %apply filter to each image patch
    if(strcmp(filtType,'Box')) %Apply box filter
        numAvg = (1/(filtSize*filtSize)); %normalization constant
        for pixel = 1:size(imagePatch,3)
            filteredImage(pixel) = floor(sum(sum(numAvg*imagePatch(:,:,pixel))));
        end
    elseif(strcmp(filtType,'Median')) %Apply median filter
        for pixel = 1:size(imagePatch,3)
            mat = imagePatch(:,:,pixel);
            filteredImage(pixel) = median(mat(:));
        end
    end

    %reconstruct image from vector
    filteredImage = reshape(filteredImage,imageSize.row,imageSize.col)';
    
    %display filtered image
    figure();
    colormap(gray);
    imagesc(filteredImage);
    colorbar;
    title(['Noisy Image Filtered with a ' num2str(filtSize) 'x'  num2str(filtSize) ' ' filtType{:} ' Filter']);

    
catch 
    disp('Invalid parameters: please check filter name and filter size');
end


end