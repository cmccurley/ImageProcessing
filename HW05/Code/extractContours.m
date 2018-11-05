function [boundImage] = extractContours(image)

%{ 
%%***********************************************************************
%    *  File:  extractContours.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Finds the boundary between foreground and background
%    *  Input: image - 3 channel binary image 
%    *  Output: boundImage -  single channel binary image of boundary mask
%%**********************************************************************
%} 

binaryImages = {};

for n = 1:size(image,3)
    binaryImages{n} = image(:,:,n); 
end

% %combine images using logical AND
% newImage = binaryImages{1}.*binaryImages{2};
% newImage = newImage.*binaryImages{3};
% figure();
% colormap(gray);
% imagesc(newImage);
% title('Combined Image');

%combine images using logical OR
combinedImage = binaryImages{1}|binaryImages{2};
combinedImage = combinedImage|binaryImages{3};
figure();
colormap(gray);
imagesc(combinedImage);
title('Combined Image');

%perform morphological opening to "clean" image (erosion then dilation)
seOpen = strel('disk',10);
openedImage = erodeImage(combinedImage, seOpen.Neighborhood);
openedImage = dilateImage(openedImage, seOpen.Neighborhood);
figure();
colormap(gray);
imagesc(openedImage);
title('Image after Opening')

%use morphological closing to fill gaps (dilation then erosion)
seClose = strel('disk',15);
closedImage = dilateImage(openedImage, seClose.Neighborhood);
closedImage = erodeImage(closedImage, seClose.Neighborhood);
figure();
colormap(gray);
imagesc(closedImage);
title('Image after Closing')

%perform boundary extraction (image - (image eroded by se2))
seBound = ones(3,3);
erodedImage = erodeImage(closedImage,seBound);
boundImage = closedImage - erodedImage;
figure();
colormap(gray);
imagesc(boundImage);
title('Boundary Extracted Image');

%Set eight neighborhood of 1 pixels as ones to thicken boundaries
[oneRow,oneCol] = find(boundImage==1);

for ind = 1:length(oneRow)
    try
        boundImage(oneRow(ind)-1,oneCol(ind)-1) = 1; % Upper left
    end
    try
        boundImage(oneRow(ind)-1,oneCol(ind)) = 1; % Upper middle
    end
    try
        boundImage(oneRow(ind)-1,oneCol(ind)+1) = 1; % Upper right
    end
    try
        boundImage(oneRow(ind),oneCol(ind)-1) = 1; % left
    end
    try
        boundImage(oneRow(ind),oneCol(ind)+1) = 1; % right
    end
    try
        boundImage(oneRow(ind)+1,oneCol(ind)+1) = 1; % Lowerleft
    end
    try
        boundImage(oneRow(ind)+1,oneCol(ind)) = 1; % lower middle  
    end
    try
        boundImage(oneRow(ind)+1,oneCol(ind)-1) = 1; % Lower left   
    end
end

figure();
colormap(gray);
imagesc(boundImage);

end