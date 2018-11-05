function [connectedCompImage] = connectedComp(image, se, gt)

%{ 
%%***********************************************************************
%    *  File:  connectedCompImage.m
%    *  Name:  Connor McCurley
%    *  Date:  10/31/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Finds connected components in the image
%    *  Input: image - MxN binary image, se - binary KxK structuring
               element, gt - matrix of row/col example positions for organ
               types
%    * Output: connectedCompImage - MxN binary image
%%**********************************************************************
%} 

numCC = 4;
connectedCompImages = {};
connectedCompImage = zeros(size(image));

disp('Finding connected components');

for cc = 1:size(gt,1)
   X = zeros(size(image));
   X(gt(cc,1),gt(cc,2)) = 1;
   Xdilated = dilateImage(X, se);
   Xnew = Xdilated.*image;
   while (nnz(Xnew-X))
       X = Xnew;
       Xdilated = dilateImage(X, se);
       Xnew = Xdilated&image;
   end
    disp('Found a connected component');
    
    %Color segment with label
    connectedCompImages{cc} = gt(cc,3).*Xnew;
end

%Combine coneected components into single image
for comp =  1:length(connectedCompImages)
    connectedCompImage = connectedCompImage + connectedCompImages{comp};
end

%black, yellow, green, red
colors = [0 0 0; 255 255 0; 0 255 0;  255 0 0];
colors = colors./255;
figure();
colormap(colors);
imagesc(connectedCompImage);
title('Image Segmented into Organ Type');

end