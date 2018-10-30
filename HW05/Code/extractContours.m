function [segmentedImage] = extractContours(image)

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


iImage = binaryImages{1};

newImage = medfilt2(iImage,[9 9]);
figure();
colormap(gray);
imagesc(newImage);

iImage = binaryImages{2};

newImage = medfilt2(iImage,[9 9]);
figure();
colormap(gray);
imagesc(newImage);
iImage = binaryImages{3};

newImage = medfilt2(iImage,[9 9]);
figure();
colormap(gray);
imagesc(newImage);

newImage = binaryImages{1}.*binaryImages{2};
newImage = newImage.*binaryImages{3};
figure();
colormap(gray);
imagesc(newImage);


newImage = medfilt2(iImage,[9 9]);
figure();
colormap(gray);
imagesc(newImage);


end