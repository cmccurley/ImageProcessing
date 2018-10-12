function [denoisedImage] = removeInterference(image)

%{ 
%%***********************************************************************
%    *  File:  removeInterference.m
%    *  Name:  Connor McCurley
%    *  Date:  10/11/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  This function takes an image with frequency interference,
%              finds the out-of-place components, and adjusts the level
%              to remove the interference from the image.
%    *  Input: image - MxN uint8 image
%    * Output: denoisedImage - MxN uint8 denoised image 
%%**********************************************************************
%} 

sigma = 15; %gaussian kernel bandwidth

%Show corrupted image
figure();
colormap(gray);
imagesc(interference);
colorbar;
title('Image with Interference');

%Transfer image to frequency domain
dftImage = fftshift(fft2(image));

%create gaussian low-pass filter
H = fspecial('gaussian',size(dftImage),sigma);
figure();
imagesc(H);
title(['Gaussian Low-Pass Kernel with Sigma: ' num2str(sigma)]);

%plot DFT of corrupted image
figure();
imagesc(abs(dftImage));
title('Magnitude of DFT for Image with Interference');

%correct image by applying median filter
denoisedFreqImage = H.*dftImage;
figure();
imagesc(abs(denoisedFreqImage));
title('Magnitude of DFT of the Denoised Image');

%convert back to spatial domain
denoisedImage = abs((ifft2(ifftshift(denoisedFreqImage))));

%plot corrected image
figure();
colormap(gray);
imagesc(denoisedImage);
title('Image with Interference Corrected');
end