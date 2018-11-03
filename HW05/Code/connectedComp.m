function [connectedCompImage] = connectedComp(image, se, gt)

%{ 
%%***********************************************************************
%    *  File:  connectedCompImage.m
%    *  Name:  Connor McCurley
%    *  Date:  10/31/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  Finds connected components in the image
%    *  Input: image - MxN binary image, se - binary KxK structuring
               element
%    * Output: connectedCompImage - MxN binary image
%%**********************************************************************
%} 

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
    disp('Found connected component');
end

end