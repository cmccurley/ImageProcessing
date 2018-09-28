function [filteredImage] = myfilt(image,filtType,filtSize)

%{ 
%%***********************************************************************
%    *  File:  myfilt.m
%    *  Name:  Connor McCurley
%    *  Date:  09/26/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  This script takes and image, applies either a 
%              median or box filter, and returns the filtered
%              image.
%    *  Input: image - NxN uint8 image
%              filtType - cell containing the name of filter
%                         to be applied. i.e. {'Box'} or {'Median'}
%              filtSize - odd integer size of filter to apply 
%                         i.e. filtSize=9 applies a 9x9 kernel
%    * Output: filteredImage - NxN uint8 filtered image 
%%**********************************************************************
%} 

%============= Throw usage instructions if error ==========================
try
    %================ Make sure filtType is a cell ========================
    if(~iscell(filtType))
        filtType = {filtType};
    end
    
    %==================== initialize vaiables =============================
    [imageSize.row,imageSize.col] = size(image); %get size of original image
    filteredImage = zeros(imageSize.row*imageSize.col,1); %column vector of filtered pixels
    
    %apply zero padding to the image
    padSize = floor(filtSize/2); %number of rows/columns to pad with
    paddedImage = padarray(image,[padSize padSize]); %zero pad original image
    [padImSize.row,padImSize.col] = size(paddedImage); %get size of padded image
    
    %===== separate matrix into patches of size filtSize by filtSize ======
    ind = 1;
    imagePatch = zeros(filtSize,filtSize,imageSize.row*imageSize.col);
    for row = 1:(padImSize.row-filtSize+1)
        for col = 1:(padImSize.col-filtSize+1)
            imagePatch(:,:,ind) = paddedImage(row:(row+filtSize-1),col:((col+filtSize-1))); 
            ind = ind+1;
        end
    end
    
    %==== apply filter to each image patch and save as single pixel =======
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

    %======= reconstruct image from filtered pixel vector =================
    filteredImage = reshape(filteredImage,imageSize.row,imageSize.col)';
    filteredImage = uint8(filteredImage);
    
    % ================== display filtered image ===========================
    figure();
    colormap(gray);
    imagesc(filteredImage);
    colorbar;
    title(['Noisy Image Filtered with a ' num2str(filtSize) 'x'  num2str(filtSize) ' ' filtType{:} ' Filter']);

    
catch %Throw error to screen
    fprintf('Invalid parameters: \n * \n * \n * \n * \n');
    help myfilt
end


end