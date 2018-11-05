%{ 
***********************************************************************
    *  File:  mccurleyHW05.m
    *  Name:  Connor McCurley
    *  Date:  10/29/2018
    *  Course: EEE 6512 Image Processing and Computer Vision
    *  Desc:  This code runs the scripts for problem 1 and the extra
              credit for homework 05
**********************************************************************
%} 

% =========================================================================
% ======================= %Clear Workspace ================================
% =========================================================================
clear all;
close all;
clc;
dbstop if error;

% =========================================================================
% =========================== %Load data ================================== 
% =========================================================================
scene = imread('pic1.ppm'); 
ex1 = imread('ex1.pgm');
ex2 = imread('ex2.pgm');

% =========================================================================
% =========================== %Run functions ==============================
% =========================================================================

% ============================ Problem 1 ==================================

%extract foreground using Otsu's method
[threshImage] = otsu(scene);

% load('threshImage.mat');

%extract contours
[segmentedImage] = extractContours(threshImage);

%plot image with boundary mask
plotMask(scene,segmentedImage);

% ========================== Extra Credit =================================

load('gt.mat'); %single points within each organ of interest for connected components

%Find organs of interest in the extra credit images
[ex1] = otsuBinary(ex1);
[ex1] = segmentOrgans(ex1,gt);

[ex2] = otsuBinary(ex2);
[ex2] = segmentOrgans(ex2,gt);



