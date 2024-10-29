% Ejercicio 3 - Convolución mediante la FFT en Octave

% Parámetros
Fs = 1 / 0.0001; % Frecuencia de muestreo (10 kHz)
Nx = 301; % Número de muestras para x[n]
Nh = 51;  % Número de muestras para h[n] (impar para centrar)
Fc = 800; % Frecuencia de corte

% Vector de tiempo
dt = 1 / Fs; % Intervalo de muestreo
n_x = 0:(Nx-1); % Vector de índices para x[n]
n_h = -(Nh-1)/2:(Nh-1)/2; % Vector de índices centrado para h[n]

% Definición de la señal x[n] (muestras de la señal analógica)
x = -5 * cos(2 * pi * 100 * n_x * dt) + 3 * sin(2 * pi * 1500 * n_x * dt);

% Definición de la respuesta al impulso h[n]
h = 2 * Fc * dt * sinc(2 * Fc * dt * n_h);

% Redimensionamos x y h para que tengan longitud N = 512 (potencia de 2)
N = 512;
x_padded = [x, zeros(1, N - length(x))];
h_padded = [h, zeros(1, N - length(h))];

% Convolución mediante FFT
X = fft(x_padded);
H = fft(h_padded);
Y = X .* H; % Multiplicación en el dominio de la frecuencia
y_fft = ifft(Y); % Transformada inversa para obtener y[n]

% Gráficos
figure;

% Primer columna: señales en el dominio del tiempo
subplot(3, 2, 1);
stem(0:N-1, x_padded, 'filled'); title('x[n] en tiempo'); xlabel('n'); ylabel('Amplitud');

subplot(3, 2, 3);
stem(0:N-1, h_padded, 'filled'); title('h[n] en tiempo'); xlabel('n'); ylabel('Amplitud');

subplot(3, 2, 5);
stem(0:N-1, y_fft, 'filled'); title('y[n] en tiempo (FFT)'); xlabel('n'); ylabel('Amplitud');

% Segunda columna: Magnitud en el dominio de la frecuencia
subplot(3, 2, 2);
stem(0:N-1, abs(X), 'filled'); title('|X[k]| en frecuencia'); xlabel('k'); ylabel('Magnitud');

subplot(3, 2, 4);
stem(0:N-1, abs(H), 'filled'); title('|H[k]| en frecuencia'); xlabel('k'); ylabel('Magnitud');

subplot(3, 2, 6);
stem(0:N-1, abs(Y), 'filled'); title('|Y[k]| en frecuencia'); xlabel('k'); ylabel('Magnitud');

% Mostrar los gráficos
sgtitle('Resultados del Ejercicio 3 - Convolución usando FFT');
