x = -10:10;
y = x.^2;

figure;
plot(x, y);
xlim([-5, 5]);  % Mostrar solo desde x = -5 hasta x = 5
title('Gráfica con xlim');
xlabel('Eje X');
ylabel('Eje Y');
