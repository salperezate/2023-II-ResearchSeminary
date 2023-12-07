% TWO-FRAME ALGORITHM

%% Clear and close everything
clear; close all; clc;

%% 2. Load the data
% 2.1. Load from ss_alcalde
% I0 = imread('pictures/ss_alcalde/I0.png');
% I1 = imread('pictures/ss_alcalde/I1.png');
% I2 = imread('pictures/ss_alcalde/I2.png');
% I3 = imread('pictures/ss_alcalde/I3.png');
% I4 = imread('pictures/ss_alcalde/I4.png');

% 2.2. Load from ss_illustrator
% I0 = imread('pictures/ss_illustrator/I0.png');
% I1 = imread('pictures/ss_illustrator/I1.png');
% I2 = imread('pictures/ss_illustrator/I2.png');
% I3 = imread('pictures/ss_illustrator/I3.png');
% I4 = imread('pictures/ss_illustrator/I4.png');

% 2.3. Load from ss_lightshot
I0 = imread('pictures/ss_lightshot/I0.png');
I1 = imread('pictures/ss_lightshot/I1.png');
I2 = imread('pictures/ss_lightshot/I2.png');
I3 = imread('pictures/ss_lightshot/I3.png');
I4 = zeros(size(I0));

% 2.4. Load from ss_mac
% I0 = imread('pictures/ss_mac/I0.png');
% I1 = imread('pictures/ss_mac/I1.png');
% I2 = imread('pictures/ss_mac/I2.png');
% I3 = imread('pictures/ss_mac/I3.png');
% I4 = imread('pictures/ss_mac/I4.png');
% Original THREE-FRAME ALGORITH

% Convert to grayscale and double
% I0 = rgb2gray(I0);
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);
I3 = rgb2gray(I3);
I4 = rgb2gray(I4);

I0 = im2double(I0);
I1 = im2double(I1);
I2 = im2double(I2);
I3 = im2double(I3);
I4 = im2double(I4);

% Obtain the size of the images
[height, width, channels] = size(I0);

% Define chi
chi = 10; % Degrees

% Create two matrix: delta and phi, both of them with the same size as the
% images. Delta represents the retardance and phi the azimuth.
delta = zeros(height, width);
phi = zeros(height, width);

% Create two matrix: A and B, both of them with the same size as the
% images. A and B are used to calculate the retardance and azimuth.
A = zeros(height, width);
B = zeros(height, width);

% Create two matrix: delta_d and phi_d, both of them with the same size as the
% images. Delta_d represents the retardance in degrees and phi_d the azimuth in degrees.
delta_d = zeros(height, width);
phi_d = zeros(height, width);

