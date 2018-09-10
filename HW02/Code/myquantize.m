function [quantData] = myquantize(data,quant_num,dataSet)
%{ 
***********************************************************************
    *  File:  myquantize.m
    *  Name:  Connor McCurley
    *  Date:  09/09/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  
**********************************************************************
%} 
data = double(data);

%Show image
figure();
colormap(gray);
imagesc(data);
colorbar;
if(nargin>1)
    title([dataSet ' Intensity Image']); 
else
   title('Intensity Image');
end

%Find maximum intensity value 
maxVal = 256;

%Define quantization interval (length of each interval)
%(max)/numIntervals
quantInt = (maxVal/quant_num);

%Find quantization index of each pixel
%pixelIntensity/quantizationInterval
quantIndicies = data;
quantIndicies = floor(quantIndicies./quantInt);

%Quantize image
%(quantIndex*quantInterval)+(quantInterval/2)
quantData = (quantIndicies*quantInt)+(quantInt/2);

%set colorbar axes
quantLevels = 0:(quant_num-1);
% discreteVals = (discreteVals*quantInt)+(quantInt/2);

%Show image
figure();
colormap(gray);
imagesc(quantData);
cmap = colormap(gray(quant_num)); 
cbh = colorbar; 
cbh.Ticks = linspace(0, 1, quant_num); 
cbh.TickLabels = num2cell(0:(quant_num-1));  
if(nargin>1)
    title([dataSet ' Intensity Image Quantized to ' num2str(quant_num) 'Levels']); 
else
   title(['Intensity Image Quantized to ' num2str(quant_num) ' Levels']);
end

end