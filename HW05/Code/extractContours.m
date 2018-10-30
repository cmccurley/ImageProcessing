function [segmentedImage] = extractContours(image)

%{ 
%%***********************************************************************
%    *  File:  removeInterference.m
%    *  Name:  Connor McCurley
%    *  Date:  10/29/2018
%    *  Course: EEE 6512 Image Processing and Computer Vision
%    *  Desc:  
%    *  Input: 
%    * Output: 
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