function [normHist] = myhist(data,dataSet)
%{ 
***********************************************************************
    *  File:  myhist.m
    *  Name:  Connor McCurley
    *  Date:  09/09/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  Takes an intensity image 'data' and the data set name
              'dataSet' (optional), and returns a vector of the image's
              normalized intensity histogram
**********************************************************************
%} 

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


%Define number of histogram bins and initialize vector of histogram values
numBins = 256;
unnormHist = zeros(numBins,1);
bins = 0:(numBins-1);

%Get normalizing constant
normConst = size(data,1)*size(data,2);

%Get unnormalized histogram
for bin = 1:numBins
    unnormHist(bin) = sum(data(:) == (bin-1));
end

%Normalize histogram
normHist = unnormHist./normConst;

%Plot normalized histogram
figure();
bar(bins,normHist);
xlabel('Intensity');
ylabel('Normalized Frequency');
if(nargin>1)
    title([dataSet ' Normalized Histogram']); 
else
   title('Normalized Histogram');
end

end