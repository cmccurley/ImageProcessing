%{ 
***********************************************************************
    *  File:  mccurleyHW05.m
    *  Name:  Connor McCurley
    *  Date:  10/29/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  
**********************************************************************
%} 

% ======================= %Clear Workspace ================================
clear all;
close all;
clc;
dbstop if error;
% =========================== %Load data ================================== 
scene = imread('pic1.ppm'); 

% =========================== %Set Parameters =============================


% =========================== %Run functions ==============================
%extract foreground using Otsu's method
[threshImage] = otsu(scene);

%extract contours
[segmentedImage] = extractContours(threshImage);





