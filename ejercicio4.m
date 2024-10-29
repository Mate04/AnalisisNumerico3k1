% Parámetros iniciales
Fm = input("Ingrese la frecuencia de muestreo (Hz): ");
Nx = 301; % Número de muestras de la señal de entrada
Nh = 51;  % Tamaño del filtro
Fc = 800; % Frecuencia de corte (Hz)

% Definición del tiempo y señales de entrada
t = (0:Nx-1) / Fm; % Tiempo en segundos para la señal de entrada
x_n = -5 * cos(2 * pi * 100 * t) + 3 * sin(2 * pi * 1500 * t); % Señal de entrada

% Generar el filtro paso bajo con ventana de Hamming
n_h = -(Nh-1)/2 : (Nh-1)/2; % Índices para la respuesta al impulso
h_n = 2 * Fc / Fm * sinc(2 * Fc / Fm * n_h); % Respuesta al impulso ideal
w_hamming = hamming(Nh)'; % Ventana de Hamming
h_n = h_n .* w_hamming; % Aplicar la ventana al filtro

% Normalización del filtro
h_n = h_n / sum(h_n);

% Convolución directa en el dominio del tiempo
y_n_time = conv(x_n, h_n, 'same');

% Convolución en el dominio de la frecuencia usando FFT
N = 512; % Tamaño para la FFT
X_k = fft([x_n, zeros(1, N - length(x_n))]);
H_k = fft([h_n, zeros(1, N - length(h_n))]);
Y_k = X_k .* H_k;
y_n_fft = ifft(Y_k);

% Frecuencias analógicas (en Hz)
frequencies = (0:N-1) * (Fm / N);

% Gráficos en 4 filas y 2 columnas
figure;

% 1. Señal de entrada en el tiempo
subplot(4, 2, 1);
plot(t, x_n);
title('Señal de entrada x[n]');
xlabel('Tiempo (s)'); ylabel('Amplitud');

% 2. Espectro de la señal de entrada
subplot(4, 2, 2);
stem(frequencies, abs(X_k));
title('FFT de x[n]');
xlabel('Frecuencia (Hz)'); ylabel('|X[k]|');

% 3. Respuesta al impulso del filtro
subplot(4, 2, 3);
stem(n_h / Fm, h_n);
title('Respuesta al impulso h[n]');
xlabel('Tiempo (s)'); ylabel('Amplitud');

% 4. Espectro del filtro (FFT)
subplot(4, 2, 4);
stem(frequencies, abs(H_k));
title('FFT de h[n]');
xlabel('Frecuencia (Hz)'); ylabel('|H[k]|');

% 5. Salida por convolución en el tiempo
subplot(4, 2, 5);
plot(t, y_n_time(1:Nx));
title('Salida y[n] (convolución tiempo)');
xlabel('Tiempo (s)'); ylabel('Amplitud');

% 6. Espectro de la salida (convolución en el tiempo)
subplot(4, 2, 6);
stem(frequencies, abs(fft(y_n_time, N)));
title('FFT de y[n] (convolución tiempo)');
xlabel('Frecuencia (Hz)'); ylabel('|Y[k]|');

% 7. Salida por convolución en el dominio de la frecuencia
subplot(4, 2, 7);
plot(t, real(y_n_fft(1:Nx)));
title('Salida y[n] (convolución FFT)');
xlabel('Tiempo (s)'); ylabel('Amplitud');

% 8. Espectro de la salida (convolución FFT)
subplot(4, 2, 8);
stem(frequencies, abs(Y_k));
title('FFT de y[n] (convolución FFT)');
xlabel('Frecuencia (Hz)'); ylabel('|Y[k]|');


