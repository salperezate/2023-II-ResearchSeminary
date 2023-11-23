clear all
close all
clc

%Importar el archivo de la imagen

[filename, path] = uigetfile('*.mat', 'Selecciona un archivo .mat');
file_path = fullfile(path, filename);
loaded_data = load(file_path);
matriz_names = fieldnames(loaded_data);

for i = 1:length(matriz_names)
    variable_name = matriz_names{i};
    assignin('base', variable_name, loaded_data.(variable_name));
end

I0 = im2double(I0);
I1 = im2double(I1);
I2 = im2double(I2);
I3 = im2double(I3);

% figure;
% imagesc(I0,[0,255])
% colormap("gray")
% colorbar

% figure;
% imagesc(I1,[0,255])
% colormap("gray")
% colorbar
% 
% figure;
% imagesc(I2,[0,255])
% colormap("gray")
% colorbar
% 
% figure;
% imagesc(I3,[0,255])
% colormap("gray")
% colorbar

%%

clear all 
close all
clc

% Pide al usuario que seleccione las imágenes
[filenames, folder] = uigetfile('*.jpg', 'Seleccione las imágenes', 'MultiSelect', 'on');

% Comprueba si el usuario ha cancelado la selección
if isequal(filenames, 0)
    disp('Selección de imágenes cancelada.');
    return;
end

% Inicializa una celda para almacenar las imágenes
images = cell(1, numel(filenames));

% Itera a través de las imágenes seleccionadas
for i = 1:numel(filenames)
    % Lee la imagen
    img = imread(fullfile(folder, filenames{i}));

    % Almacena la imagen en la celda
    images{i} = img;

    % Obtiene el nombre del archivo (sin extensión)
    [~, name, ~] = fileparts(filenames{i});

    % Asigna la imagen al espacio de trabajo con el nombre del archivo
    assignin('base', name, img);
end

% Informa al usuario que las imágenes han sido cargadas
disp('Imágenes cargadas en el espacio de trabajo con nombres de archivo como variables.');

I0 = rgb2gray(I0);
I0 = im2double(I0);

I1 = rgb2gray(I1);
I1 = im2double(I1);

I2 = rgb2gray(I2);
I2 = im2double(I2);

I3 = rgb2gray(I3);
I3 = im2double(I3);

figure;
imshow(I0)
colormap("gray")
colorbar

%%
% Cálculo de retardo y ángulo azimutal

swing = 45;
[filas, columnas] = size(I0);
matriz_delta = zeros(size(filas,columnas));
matriz_fi = zeros(size(filas,columnas));

for fila = 1:filas
    for columna = 1:columnas

        I_0a = I0(fila, columna);
        I_1a = I1(fila, columna);
        I_2a = I2(fila, columna);
        I_3a = I3(fila, columna);

        A1 = I_1a-I_2a;
        B1 = I_1a+I_2a-2*I_3a;
        den = I_1a+I_2a-2.*I_0a;
        
        A = (A1/den)*tand(swing/2);
        B = (B1/den)*tand(swing/2);
        C = I_1a+I_2a-2*I_0a;

        if I_1a+I_2a-2*I_0a >= 0
            delta = atan(((A^2)+(B^2))^0.5);
        end 
        
        if I_1a+I_2a-2*I_0a < 0
            delta = (pi)-((atan(((A^2)+(B^2))^0.5)));
        end

        fi = 0.5*atan(A/B);

        matriz_delta(fila, columna) = delta;
        matriz_fi(fila, columna) = fi;

    end
end

figure;
imshow(matriz_delta,[0,1])
colormap("gray")
colorbar

% 
figure;
imshow(matriz_fi)
colormap("gray")
colorbar

%% 
% Cálculo de Intesidades para hacer stokes

swing2 = 45;
intensidad = 255;
intensidad_min = 50;
tao = ones(size(filas,columnas));

% Llamar retardo
retardo = matriz_delta;

% Llamar angulo azimutal
epsilon = matriz_fi;

I_0 = ((1/2).*tao*intensidad.*(1.-cos(retardo))+intensidad_min)/255;
I_1 = ((1/2).*tao*intensidad.*(1.-cosd(swing2).*cos(retardo)+sind(swing2).*sin(2.*epsilon).*sin(retardo))+intensidad_min)/255;
I_2 = ((1/2).*tao*intensidad.*(1.-cosd(swing2).*cos(retardo)-sind(swing2).*sin(2.*epsilon).*sin(retardo))+intensidad_min)/255;
I_3 = ((1/2).*tao*intensidad.*(1.-cosd(swing2).*cos(retardo)-sind(swing2).*cos(2.*epsilon).*sin(retardo))+intensidad_min)/255;
I_4 = ((1/2).*tao*intensidad.*(1.-cosd(swing2).*cos(retardo)+sind(swing2).*cos(2.*epsilon).*sin(retardo))+intensidad_min)/255;

figure;
imshow(I_0,[0,1])
colormap("gray")
colorbar
axis('off')
title('Intensidad I0');

figure;
imshow(I_1,[0,1])
colormap("gray")
colorbar
axis('off')
title('Intensidad I1');

figure;
imshow(I_2,[0,1])
colormap("gray")
colorbar
axis('off')
title('Intensidad I2');

figure;
imshow(I_3,[0,1])
colormap("gray")
colorbar
axis('off')
title('Intensidad I3');

figure;
imshow(I_4,[0,1])
colormap("gray")
colorbar
axis('off')
title('Intensidad I4');








