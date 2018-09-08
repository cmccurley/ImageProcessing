%{ 
***********************************************************************
    *  File:  mccurleyHW01.m
    *  Name:  Connor McCurley
    *  Date:  08/22/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  This code loads two matrices containing the odd rows, and 
    *  even, corrupted rows of an image, repectively.  The image is then
    *  denoised by adding the row means of the odd rows to the 
    *  corresponding even rows.
**********************************************************************
%} 

% ======================= %Clear Workspace ================================
clear all;
close all;
clc;

% =========================== %Load data ==================================
load('odd_rows.mat'); load('even_rows.mat');

% ======================= %Display Images =================================
figure(); 

%Display odd rows
subplot(2,2,1);
imagesc(odd_channel);
title('Image Demonstrating Odd Rows');
xlabel('Column Index');
ylabel('Row Index');

%Display even rows
subplot(2,2,2);
imagesc(even_corrupted_channel);
title('Image Demonstrating Corrupted, Even Rows')
xlabel('Column Index');
ylabel('Row Index');

%Display corrupted image
subplot(2,2,3);
imagesc(reshape([odd_channel(:) even_corrupted_channel(:)]',2*size(odd_channel,1),[]));
title('Corrupted Image')
xlabel('Column Index');
ylabel('Row Index');

%Display un-corrupted image
subplot(2,2,4);
imagesc(reshape([odd_channel(:) reshape(bsxfun(@plus,even_corrupted_channel,mean(odd_channel,2)),size(odd_channel,1)*size(odd_channel,2),1)]',2*size(odd_channel,1),[]));
title('Un-corrupted Image')
xlabel('Column Index');
ylabel('Row Index');

%Odd and even row combination description:
%Row interweaving is done by vectorizing each matrix into a column vector,
%horizontially concatentating the two column vectors, taking the transpose
%to make a 2 by numPixels matrix, and reshaping the matrix into a
%2*numRows by numColumns matrix.  This effectively interweaves the two
%original matrices.  Additionally, the even row matrix is un-corrupted by
%adding to each element the corresponding odd row's mean.  This is done
%before interweaving.