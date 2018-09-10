%{ 
***********************************************************************
    *  File:  mccurleyHW02.m
    *  Name:  Connor McCurley
    *  Date:  09/09/2018
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
flower = imread('flower.pgm'); 
swan = imread('swan.pgm'); 
tools = imread('tools.pgm');

% =========================== %Set Parameters =============================
quant_num = 8;

runHist = 0;
runHistEq = 0;
runQuant = 0;

% =========================== %Run functions ==============================

if (runHist)
    %Compute normalized histogram
    [flowerHist] = myhist(flower,'Flowers');
    [swanHist] = myhist(swan,'Swan');
    [toolsHist] = myhist(tools,'Tools');
end

if (runHistEq)
    %Compute equalized histogram
    [flowerHistEq] = myhisteq(flower,'Flowers');
    [swanHistEq] = myhisteq(swan,'Swan');
    [toolsHistEq] = myhisteq(tools,'Tools');
end

if (runQuant)
    %Compute quantized image
    [flowerQuant] = myquantize(flower, quant_num, 'Flowers');
    [swanQuant] = myquantize(swan, quant_num, 'Swan');
    [toolsQuant] = myquantize(tools, quant_num, 'Tools');
end