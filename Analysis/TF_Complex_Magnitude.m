clear all;
close all;
%--- create TF
zeros = [];
poles = [complex(-10, 5) complex(-10, -5)];
gain = 1;
G = zpk(zeros, poles, gain)
%--- basic analysis
figure();
bode(G);
figure();
pzmap(G);
%--- surface plot
n = 101; % subdivision of axis
sigma_values = linspace(-20,20,n); %change range of sigma here
omega_values = linspace(-10,10,n); %change range of omega here
for a = 1:n
        Gplot(:,a) = abs(freqresp(G,complex(sigma_values, omega_values(a))));
end
figure();
surface = surf(omega_values, sigma_values, Gplot);
title('Transfer Function Complex Magnitude');
xlabel('omega');
ylabel('sigma');
zlabel('|G|');