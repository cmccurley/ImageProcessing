function [segmentedImages] = colorSegmentation(scene)

%{ 
%%***********************************************************************
%    *  File:  colorSegmentation.m
%    *  Name:  Connor McCurley
%    *  Date:  10/11/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  This function takes in an rgb color image and 
%              performs segmentation using three different color
%              spaces: rgb, hsi, and lab.
%    *  Input: image - MxN rgb image
%    * Output: segmentedImages - cell containing three MxN images 
%              segmented in different color spaces
%%**********************************************************************
%} 
rgbImage = scene;
figure();
imshow(rgbImage);
title('RGB Image of a Scene');

%================= convert rgb to hsi =====================================
hsiImage = rgb2hsv(scene);

figure();
imshow(hsiImage);
title('HSI Image of a Scene');

hsiImage = hsiImage(:,:,1:2); %discard intensity for segmentation
%==========================================================================

%================= convert rgb to lab =====================================
labImage = rgb2lab(scene);

figure();
imshow(labImage);
title('LAB Image of a Scene');
%==========================================================================


Images = {rgbImage,hsiImage,labImage};
ImageNames = {'RGB Image', 'HSI Image', 'LAB Image'};


%define discrete colors
colorNames = ['Black','Brown','Purple','Orange','Yellow','Green','Blue','Red'];
colors = [0 0 0; 139,69,19;255,0,255;255,165,0;255,255,0;0,255,0;0,0,255;255,0,0];
colors = colors./255;


for image = 1:size(Images,2)
   %define sample regions for each class
   sky1 = Images{image}(86:200,32:208,:);
   sky2 = Images{image}(636:667,307:346,:);
   cloud = Images{image}(32:288,624:721,:);
   tree = Images{image}(667:786,706:709,:);
   sand1 = Images{image}(1130:1220,250:442,:);
   sand2 = Images{image}(1180:1200,775:825,:);
   water = Images{image}(769:804,421:474,:);
   rocks = Images{image}(1200:1210,873:886,:);
   
   %create labels
   protMats = {sky1,sky2,cloud,tree,sand1,sand2,rocks};
   labels = 1:1:size(protMats,2);
   
   prototypes = [];
   
   %take average of class regions
   for mat = 1:size(protMats,2)
       matrix = protMats{mat};
       matVector = reshape(matrix,[],3);
       avgVect = mean(matVector);
       prototypes = horzcat(prototypes,avgVect');
   end
   
   
   
   
end


%plot each binned image
for image = 1:size(pcImages,2)
    figure();
    colormap(colors);
    imagesc(pcImage{image});
    cmap = colormap(colors(numBins)); 
    cbh = colorbar; 
    cbh.Ticks = linspace(0, 1, numBins);  
end



end