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

%% Questao 3
% ponto de operaçao
u_0 = 1;
Caf_0 = 5.1;
Ca_0 = 0.7192;
Cb_0 = 2.345;
% TFs
s = tf('s');
Ca_U = (Caf_0 - Ca_0)/(s + k1 + 2*Ca_0*k3 + u_0); % Ca/U
Ca_Caf = (u_0)/(s + k1 + 2*Ca_0*k3 + u_0); % Ca/Caf
Cb_Ca = (k1)/(s + k2 + u_0); % Cb/Ca
Cb_U = (Cb_0)/(s + k2 + u_0); % Cb/U



