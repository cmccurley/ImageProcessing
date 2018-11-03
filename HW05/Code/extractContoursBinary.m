function [boundImage] = extractContoursBinary(image,gt)

%{ 
%%***********************************************************************
%    *  File:  extractContours.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Finds the boundary between foreground and background
%    *  Input: image - single channel binary image 
%    *  Output: boundImage -  single channel binary image of boundary mask
%%**********************************************************************
%} 


%perform morphological opening to "clean" image (erosion then dilation)
seOpen = strel('disk',10);
openedImage = erodeImage(image, seOpen.Neighborhood);
openedImage = dilateImage(openedImage, seOpen.Neighborhood);
figure();
colormap(gray);
imagesc(openedImage);
title('Image after Opening')



%find the connected components
seCC = ones(3,3);
ccImage = connectedComp(openedImage, seCC, gt);
figure();
colormap(gray);
imagesc(ccImage);
title('Connected Component Image');

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