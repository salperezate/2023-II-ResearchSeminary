clear
clc

swing = 90;

% Lee las imágenes (asegúrate de tener las variables I0, I1, I2, I3 definidas)
% Ejemplo:
% I0 = imread('pictures/c/0.png');
% I1 = imread('pictures/c/1.png');
% I2 = imread('pictures/c/2.png');
% I3 = imread('pictures/c/3.png');

% I0 = imread('pictures/alcalde/I1.png');
% I1 = imread('pictures/alcalde/I2.png');
% I2 = imread('pictures/alcalde/I3.png');
% I3 = imread('pictures/alcalde/I4.png');

I0 = imread('pictures/S0.png');
I1 = imread('pictures/S1.png');
I2 = imread('pictures/S2.png');
I3 = imread('pictures/S3.png');



I0 = im2double(I0);
I1 = im2double(I1);
I2 = im2double(I2);
I3 = im2double(I3);

% Obtén el tamaño de las imágenes
[filas, columnas] = size(I0);

% Inicializa las matrices de salida
matriz_delta = zeros(filas, columnas);
matriz_fi = zeros(filas, columnas);

% Itera sobre cada píxel en las imágenes
for fila = 1:filas
    for columna = 1:columnas
        % Extrae los valores de los píxeles de las cuatro imágenes
        I_0a = I0(fila, columna);
        I_1a = I1(fila, columna);
        I_2a = I2(fila, columna);
        I_3a = I3(fila, columna);

        % Calcula las diferencias y el denominador común
        A1 = I_1a - I_2a;
        B1 = I_1a + I_2a - 2 * I_3a;
        den = I_1a + I_2a - 2 * I_0a;

        % Calcula los ángulos A, B, y C
        A = (A1 / den) * tand(swing / 2);
        B = (B1 / den) * tand(swing / 2);
        C = I_1a + I_2a - 2 * I_0a;

        % Calcula el ángulo delta
        if C >= 0
            delta = atan(sqrt(A^2 + B^2));
        else
            delta = 180-((atan(((A^2)+(B^2))^0.5)));
        end

        % Calcula el ángulo fi
        fi = 0.5 * atan(A / B);

        % Almacena los resultados en las matrices de salida
        matriz_delta(fila, columna) = delta;
        matriz_fi(fila, columna) = fi;
    end
end

% Muestra la imagen de delta
figure;
imshow(matriz_delta, [0, 1])
colormap("gray")
colorbar
title('Ángulo Delta')

% Muestra la imagen de fi
figure;
imshow(matriz_fi)
colormap("gray")
colorbar
title('Ángulo Fi')
