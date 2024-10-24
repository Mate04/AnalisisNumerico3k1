close all;
clc;

delta_t = 0.0001;

nx = 0:delta_t:0.03;

x_n = -5 * cos(2 * pi * 100 * nx) + 3 * sin(2 * pi * 1500 * nx);

fc = 500;

h_n = 2 * fc * delta_t * sinc(2 * fc * (nx - (max(nx) / 2)));


y_n = conv(x_n, h_n) * delta_t;

ny = 0:delta_t:(length(y_n) - 1) * delta_t;

numero_graficos = 3;

figure;

subplot(numero_graficos, 1, 1);
stem(nx, x_n);
title('Señal x_n');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(numero_graficos, 1, 2);
stem(nx, h_n);
title('Filtro h_n');
xlabel('Tiempo (s)');
ylabel('Amplitud');

subplot(numero_graficos, 1, 3);
plot(ny, y_n);
title('Convolución y_n = x_n * h_n');
xlabel('Tiempo (s)');
ylabel('Amplitud');

