%{ 
***********************************************************************
    *  File:  mccurleyHW03.m
    *  Name:  Connor McCurley
    *  Date:  09/26/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  This script allows the user to run either a Median or Box
              filter with varying sizes on a noisy image as required
              by HW03.
**********************************************************************
%} 

% ======================= %Clear Workspace ================================
clear all;
close all;
clc;

% =========================== %Load data ==================================
image = imread('noisy.pgm'); 

% =========================== %Set Parameters =============================
filtSize = 3:2:9; %range of filter sizes
filtType = {'Box', 'Median'}; %filter types

% ======================= %Plot original image ============================
%Show image
figure();
colormap(gray);
imagesc(image);
colorbar;
title('Noisy Image');

% =========================== %Run functions ==============================
%apply filters over range of filter sizes
for type = 1:size(filtType,2)
    for fsize = 1:size(filtSize,2)
        [filtImage] = myfilt(image,filtType(type),filtSize(fsize));
    end
end

