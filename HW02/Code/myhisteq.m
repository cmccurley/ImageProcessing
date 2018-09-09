function [eqHist] = myhisteq(data,dataSet)
%{ 
***********************************************************************
    *  File:  myhisteq.m
    *  Name:  Connor McCurley
    *  Date:  09/09/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  
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

%Find equalized histogram values
eqHistVals = zeros(numBins,1);
for bin = 1:numBins
    eqHistVals(bin) = (bin-1)*sum(normHist(1:bin),1);
end

%Plot transformation function
figure();
bar(bins,eqHistVals); hold on;
plot(bins,repmat((numBins-1),numBins,1), 'Color', 'k', 'Linestyle','-.', 'Linewidth', 2);
xlabel('Intensity');
ylabel('Equalized Value');
if(nargin>1)
    title([dataSet ' Transformation Function']); 
else
   title('Transformation Function');
end

%Equalize image values
eqData = zeros(size(data,1),size(data,2));
for bin = 1:numBins
   ind = find(data(:)== (bin-1));
   eqData(ind) = eqHistVals(bin);
end
eqData = round(eqData);

%Show equalized image
figure();
colormap(gray);
imagesc(eqData);
colorbar;
if(nargin>1)
    title([dataSet ' Equalized Intensity Image']); 
else
   title('Equalized Intensity Image');
end

%Get normalized equalized histogram
eqHist = zeros(numBins,1);
for bin = 1:numBins
    eqHist(bin) = sum(eqData(:) == (bin-1));
end
eqHist = eqHist./normConst;

%Plot normalized equalized histogram
figure();
bar(bins,eqHist);
xlabel('Intensity');
ylabel('Normalized Frequency');
if(nargin>1)
    title([dataSet ' Equalized Histogram']); 
else
   title('Equalized Histogram');
end

end