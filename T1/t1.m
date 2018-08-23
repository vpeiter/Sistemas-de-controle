% Questao 1
clear all;
close all;

k1 = 6.01;
k2 = 0.8433;
k3 = 0.1123;

u = 0:0.5:10;
Caf = 4:0.1:6;
[U,CAF] = meshgrid(u,Caf);
Ca = [];
Cb = [];
Ca= (k1 + U - sqrt((k1 + U).^2  + 4*k3.*CAF.*U))/(-2*k3);
Cb = (Ca.*k1)./(k2 + U);
% curva estatica de Ca
figure;
surf(U, CAF, Ca);
grid on;
title('Curva estatica de Ca');
xlabel('U');
ylabel('Caf');
zlabel('Ca');
% curva estatica de Cb
figure;
surf(U, CAF, Cb);
title('Curva estatica de Cb');
xlabel('U');
ylabel('Caf');
zlabel('Cb');
