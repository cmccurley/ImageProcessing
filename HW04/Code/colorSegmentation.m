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
imagesc(rgbImage);
title('RGB Image of a Scene');

%================= convert rgb to hsi =====================================
hsiImage = rgb2hsv(scene);

figure();
imagesc(hsiImage);
title('HSI Image of a Scene');

hsiImage = hsiImage(:,:,1:2); %discard intensity for segmentation
%==========================================================================

%================= convert rgb to lab =====================================
labImage = rgb2lab(scene);

figure();
imagesc(labImage);
title('LAB Image of a Scene');
%==========================================================================

Images = {rgbImage,hsiImage,labImage};
ImageNames = {'RGB Image', 'HSI Image', 'LAB Image'}; %titles of images
saveNames = {'segmentedRGB', 'segmentedHSI', 'segmentedLAB'}; %names to save figures as


%define discrete colors
colorNames = ['Purple','Orange','Yellow','Green','Blue','Red'];
colors = [255,0,255;255,165,0;255,255,0;0,255,0;0,0,255;255,0,0];
colors = colors./255;
labelNames = {'Sky','Cloud','Sand','Plants','Water','Rock'};

segmentedImages = {};
for image = 1:size(Images,2)
    Images{image} = single(Images{image}); %cast image as a single
    
   %define sample regions for each class
   sky1 = Images{image}(86:200,32:208,:);
   sky2 = Images{image}(636:667,307:346,:);
   cloud = Images{image}(32:288,624:721,:);
   tree = Images{image}(621:712,495:886,:);
   sand1 = Images{image}(1130:1220,250:442,:);
   sand2 = Images{image}(1180:1200,775:825,:);
   water = Images{image}(769:804,421:474,:);
   rocks = Images{image}(1200:1210,873:886,:);
   
   %create labels
   protMats = {sky1,sky2,cloud,sand1,sand2,tree,water,rocks};
   labels = [1,1,2,3,3,4,5,6];
   
   prototypes = [];
   
   %take average of class regions to generate class prototypes
   for mat = 1:size(protMats,2)
       matrix = protMats{mat};
       matVector = reshape(matrix,[],size(matrix,3));
       avgVect = mean(matVector);
       prototypes = horzcat(prototypes,avgVect');
   end
   
   %take distance of each pixel to all of the prototypes and set pixel
   %label
   labelledImage = zeros(size(Images{image},1),size(Images{image},2));
   for col = 1:size(Images{image},2)
       for row = 1:size(Images{image},1)
            [distances] = pdist2(squeeze(Images{image}(row,col,:))',prototypes');
            [minVal, minInd] = min(distances);
            labelledImage(row,col) = labels(minInd);
       end
   end
   
segmentedImages{image} = uint8(labelledImage);  %cast image as uint8
disp('Finished Image');
end



%plot each segmented image
for image = 1:size(segmentedImages,2)
    figure();
    colormap(colors);
    imagesc(segmentedImages{image});
    title(['Segmented ' ImageNames{image}]);
    cmap = colormap(colors(size(labels,2)-2)); 
    cbh = lcolorbar(labelNames,'fontweight','bold');
%     saveas(gcf,saveNames{image});
end



end