% Original FOUR-FRAME ALGORITH

%% 1. Clear and close everything
clear all; close all; clc;

chi = 45; % Degrees

%% 2. Load the data
% 2.1. Load from ss_alcalde
I0 = imread('pictures/ss_alcalde/I0.png');
I1 = imread('pictures/ss_alcalde/I1.png');
I2 = imread('pictures/ss_alcalde/I2.png');
I3 = imread('pictures/ss_alcalde/I3.png');
I4 = imread('pictures/ss_alcalde/I4.png');

% 2.2. Load from ss_illustrator
% I0 = imread('pictures/ss_illustrator/I0.png');
% I1 = imread('pictures/ss_illustrator/I1.png');
% I2 = imread('pictures/ss_illustrator/I2.png');
% I3 = imread('pictures/ss_illustrator/I3.png');
% I4 = imread('pictures/ss_illustrator/I4.png');

% 2.3. Load from ss_lightshot
% I0 = imread('pictures/ss_lightshot/I0.png');
% I1 = imread('pictures/ss_lightshot/I1.png');
% I2 = imread('pictures/ss_lightshot/I2.png');
% I3 = imread('pictures/ss_lightshot/I3.png');
% I4 = imread('pictures/ss_lightshot/I4.png');

% 2.4. Load from ss_mac
% I0 = imread('pictures/ss_mac/I0.png');
% I1 = imread('pictures/ss_mac/I1.png');
% I2 = imread('pictures/ss_mac/I2.png');
% I3 = imread('pictures/ss_mac/I3.png');
% I4 = imread('pictures/ss_mac/I4.png');

% 2.5 Convert to double
I0 = im2double(I0);
I1 = im2double(I1);
I2 = im2double(I2);
I3 = im2double(I3);
I4 = im2double(I4);

% 2.6. Obtain the size of the images
[height, width] = size(I0);

% Create two matrix: delta and phi, both of them with the same size as the
% images. Delta represents the retardance and phi the azimuth.
delta = zeros(height, width);
phi = zeros(height, width);

% 2.7. Obtain the retardance and azimuth
for i = 1:height
    for j = 1:width

        % 2.7.1. Calculate A, B and denominator
        denominator = I1(i,j) + I2(i,j) - 2 * I0(i,j);

        A = ((I1(i,j) - I2(i,j))/denominator) * tand(chi/2);
        B = ((I1(i,j) + I2(i,j) - 2 * I3(i,j))/denominator) * tand(chi/2);

        % 2.7.1. Obtain the retardance
        if denominator >= 0
            delta(i,j) = atan(sqrt(A(i,j)^2 + B(i,j)^2)); % when denominator is more or equal than 0
        else
            delta(i,j) = pi() - atan(sqrt(A(i,j)^2 + B(i,j)^2)); % when denominator is less than 0
        end
        
        % 2.7.2. Obtain the azimuth
        phi(i,j) = 0.5 * atan(A(i,j)/B(i,j));
    end
end

% 2.8. Convert the retardance and azimuth to degrees
delta_d = delta * 180 / pi;
phi_d = phi * 180 / pi;

% 2.9. Show the results
% Use colormap, show colorbar, and set title
figure(1);
subplot(1,2,1);
imshow(delta_d, [0 90]);
colormap('gray');
colorbar;
title('Retardance \delta');

subplot(1,2,2);
imshow(phi_d, [-90 90]);
colormap('gray');
colorbar;
title('Azimuth \phi');