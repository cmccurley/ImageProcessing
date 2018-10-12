%{ 
***********************************************************************
    *  File:  mccurleyHW03.m
    *  Name:  Connor McCurley
    *  Date:  09/26/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  This script allows the user to run the questions asked
              in HW04.  Each question can be completed by setting
              the appropriate boolean in the 'Set Parameters' section
              of the code.
**********************************************************************
%} 

% ======================= %Clear Workspace ================================
clear all;
close all;
clc;
dbstop if error;
% =========================== %Load data ==================================
% interference = imread('interfere.pgm'); 
% flower = imread('flower.pgm'); 
% swan = imread('swan.pgm'); 
% tools = imread('tools.pgm'); 
scene = imread('scene.ppm'); 

% =========================== %Set Parameters =============================
runInterferenceRemoval = 0;
runPseudoColor = 0;
runSegmentation = 1; 

% =========================== %Run functions ==============================
%Remove interference from corrupted image
if(runInterferenceRemoval)
[denoisedImage] = removeInterference(interference);
end

%Convert intensity images into pseudo-color images
if(runPseudoColor)
    iImages = {flower, swan, tools};
    [pcImages] = pseudoColor(iImages);
end

%Segment color image using RGB, HSI, and LAB color spaces
if(runSegmentation)
   [segmentedImages] = colorSegmentation(scene);
end


