% Parámetros
Nx = 301;  % Número de muestras para x[n]
Delta_t = 0.0001;  % Intervalo de muestreo (10,000 Hz)
t = (0:Nx-1) * Delta_t;  % Vector de tiempo discreto
Fc = 800;  % Frecuencia de corte en Hz
Nh = 51;  % Tamaño de la ventana de h[n], impar
n_h = (-(Nh - 1)/2 : (Nh - 1)/2);  % Índices para h[n]

% Señal de entrada x[n]
x_n = -5 * cos(2 * pi * 100 * t) + 3 * sin(2 * pi * 1500 * t);

% Respuesta al impulso h[n]
h_n = 2 * Fc * Delta_t * sinc(2 * Fc * Delta_t * n_h);

% Ajustar dimensiones para FFT (potencia de 2)
N = 2^nextpow2(length(x_n) + length(h_n) - 1);

% Rellenar con ceros las señales x[n] y h[n]
x_n_pad = [x_n, zeros(1, N - length(x_n))];
h_n_pad = [h_n, zeros(1, N - length(h_n))];

% FFT de las señales
X_k = fft(x_n_pad);
H_k = fft(h_n_pad);

% Multiplicación en el dominio de la frecuencia
Y_k = X_k .* H_k;

% Transformada inversa para obtener y[n]
y_n_fft = real(ifft(Y_k));

% Vector de tiempo para y[n]
n_y = 0:length(y_n_fft)-1;

% Gráficos
figure;

% Primera columna: Señales en el dominio del tiempo
subplot(3,2,1);
stem(0:Nx-1, x_n, 'Marker','none');
title('Señal de entrada x[n] (Tiempo)');
xlabel('n');
ylabel('x[n]');
xlim([0 Nx-1]);

subplot(3,2,3);
stem(n_h, h_n, 'Marker','none');
title('Respuesta al impulso h[n] (Tiempo)');
xlabel('n');
ylabel('h[n]');
xlim([min(n_h) max(n_h)]);

subplot(3,2,5);
stem(n_y, y_n_fft, 'Marker','none');
title('Señal de salida y[n] (Tiempo)');
xlabel('n');
ylabel('y[n]');
xlim([0 length(y_n_fft)-1]);

% Segunda columna: Espectros en el dominio de la frecuencia
subplot(3,2,2);
stem(0:N-1, abs(X_k), 'Marker','none');
title('Espectro X[k] (Frecuencia)');
xlabel('k');
ylabel('|X[k]|');

subplot(3,2,4);
stem(0:N-1, abs(H_k), 'Marker','none');
title('Espectro H[k] (Frecuencia)');
xlabel('k');
ylabel('|H[k]|');

subplot(3,2,6);
stem(0:N-1, abs(Y_k), 'Marker','none');
title('Espectro Y[k] (Frecuencia)');
xlabel('k');
ylabel('|Y[k]|');

