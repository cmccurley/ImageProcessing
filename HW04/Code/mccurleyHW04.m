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
interference = imread('interfere.pgm'); 
flower = imread('flower.pgm'); 
swan = imread('swan.pgm'); 
tools = imread('tools.pgm'); 
scene = imread('scene.ppm'); 

% =========================== %Set Parameters =============================
runInterferenceRemoval = 0;
runPseudoColor = 1;
runSegmentation = 0;

% figure();
% imshow(scene);
% title('Color Image of a Scene');


% =========================== %Run functions ==============================
if(runInterferenceRemoval)
%Remove interference from corrupted image
[denoisedImage] = removeInterference(interference);
end

if(runPseudoColor)
    iImages = {flower, swan, tools};
    [pcImages] = pseudoColor(iImages);
end

if(runSegmentation)
   [segmentedImages] = colorSegmentation(scene);
end


