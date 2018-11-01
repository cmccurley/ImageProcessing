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
ex1 = imread('ex1.pgm');
ex2 = imread('ex2.pgm');

% =========================== %Set Parameters =============================


% =========================== %Run functions ==============================
%Problem 1

%extract foreground using Otsu's method
[threshImage] = otsu(scene);

% load('threshImage.mat');

%extract contours
[segmentedImage] = extractContours(threshImage);

%Extra Credit
% [ex1] = otsuBinary(ex1);
% [ex2] = otsuBinary(ex2);



