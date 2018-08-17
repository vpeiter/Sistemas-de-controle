s = tf('s');
% modelo para ponto de operacao em Vin=3.5v
K = 1.18; % ganho estatico
r = 0.15; % atraso
d = 1.45; % constante de tempo
G = (K/(d*s+1))*((1-s*r/2)/(1+s*r/2));

% rlocus para polos duplos
figure();
rlocus(G); % Gain: 2.48 Pole: -6


