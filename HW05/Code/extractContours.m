function [boundImage] = extractContours(image)

%{ 
%%***********************************************************************
%    *  File:  removeInterference.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  
%    *  Input: 
%    *  Output: 
%%**********************************************************************
%} 

binaryImages = {};

for n = 1:size(image,3)
    binaryImages{n} = image(:,:,n); 
end

%apply median filter to each channel to remove noise
iImage = binaryImages{1};
binaryImages{1} = medfilt2(iImage,[9 9]);
% figure();
% colormap(gray);
% imagesc(binaryImages{1});
% title('Red Channel after 3x3 Median Filtering');

iImage = binaryImages{2};
binaryImages{2} = medfilt2(iImage,[9 9]);
% figure();
% colormap(gray);
% imagesc(binaryImages{2});
% title('Green Channel after 3x3 Median Filtering');

iImage = binaryImages{3};
binaryImages{2} = medfilt2(iImage,[9 9]);
% figure();
% colormap(gray);
% imagesc(binaryImages{1});
% title('Blue Channel after 3x3 Median Filtering');

%combine images using logical AND
newImage = binaryImages{1}.*binaryImages{2};
newImage = newImage.*binaryImages{3};
figure();
colormap(gray);
imagesc(newImage);
title('Combined Image');

% %Apply median filter to combined image to remove noise
% newImage = medfilt2(newImage,[3 3]);
% figure();
% colormap(gray);
% imagesc(newImage);
% title('Combined Image after 3x3 Median Filtering')

%perform morphological closing to fill small holes

se1 = strel('disk',25);
closedImage = imclose(newImage,se1);
figure();
colormap(gray);
imagesc(closedImage);
title('Image after Closing')


%perform boundary extraction (image - (image eroded by se2))
% se2 = ones(3,3);
% erodedImage = erodeImage(closedImage,se2);
% boundImage = closedImage - erodedImage;

newImage = bwmorph(closedImage,'remove');
figure();
colormap(gray);
imagesc(newImage);
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