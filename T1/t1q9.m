k1 = 6.01;
k2 = 0.8433;
k3 = 0.1123;

% Ponto de equilíbrio Q2
Caf_0 = 5.1;
u_0 = 1;

syms Ca  % max para pegar a raiz positiva
Ca_0 = double(max(solve(0 == -k1*Ca - k3*Ca^2 + (Caf_0 - Ca)*u_0,Ca)));
syms Cb
Cb_0 = double(solve(0 == k1*Ca_0 - k2*Cb - Cb*u_0, Cb));

% Coeficientes da equação linearizada
a1 = k1 + 2*k3*Ca_0 + u_0;
a2 = Caf_0 - Ca_0;
a3 = k2 + u_0;

% Sistema linearizado
s=tf('s');
G_Cb_U = (-Cb_0*s + (a2*k1 - a1*Cb_0))/(s^2 + (a3+a1)*s + a1*a3);
G_Cb_Caf = u_0*k1/(s^2 + (a3+a1)*s + a1*a3);

% Identificação dos sistemas
    % Cb/U
tau_u = 0.5757; % baseado em 3*tau = 95%
k_u = (2.411-2.345)/0.1;
%tau_u = 0.673;
%k_u = (2.601-2.345)/2;
    % Cb/Caf
tau_Caf = 0.5;
k_Caf = 0.454;


% Parâmetros do controlador
t5 = 1.7;
tau_d = t5/4.8;

syms ti
ti = double(solve(ti + (tau_d^2)/tau_u == 2*tau_d, ti));

syms k_c
k_c = double(solve(k_c*k_u*(tau_d^2) == tau_u*ti, k_c));
k_c = 1;

% Funções de Transferência
s = tf('s');

G_U = k_u/(tau_u*s + 1);
G_Caf = k_Caf/(tau_Caf*s + 1);

PI = k_c*(1 + s*ti)/(s*ti);

F = 1/(ti*s+1);

Cb_R = F*PI*G_U/(1+PI*G_U);
Cb_Caf = G_Caf/(1+PI*G_U);


%% Questao 9


dCa = [];
dCb = [];
du = [];
dCaf = [];
Cb_ref = [];
dCa(1) = 0;
dCb(1) = 0;
du(1) = 0;
dCaf(1) = Caf_0;
Cb_ref(1) = 0;


Ts = 0.5/20; % tau/20
Tc = Ts/200;
k = 1;
for t = 0:Tc:50
    % simulação
    dCa(k+1) = dCa(k) + Tc*(-(k1+2*Ca_0*k3+u_0)*dCa(k)+(Caf_0-Ca_0)*du(k)+u_0*dCaf(k));
    dCb(k+1) = dCb(k) + Tc*(-(k2+u_0)*dCb(k)+k1*dCa(k)-Cb_0*du(k));
    % referencia
    if t < 10
        Cb_ref(k+1) = Cb_ref(k) + Cb_0/(10/Tc); % rampa de 0 a Cb_0 de t=0 a t=10
    elseif t < 30
        Cb_ref(k+1) = Cb_0;
    else
        Cb_ref(k+1) = Cb_0 + 0.2; % step em t=30
    end
    % perturbação
    if t < 40
        dCaf(k+1) = Caf_0;
    else
        dCaf(k+1) = Caf_0 + 0.2; % step em 40
    end
    % controle
    if rem(t,Ts) == 0
        e(k+1) = Cb_ref(k+1) - dCb(k+1);
        du(k+1) = du(k)+k_c*(e(k+1)+(Ts/ti-1)*e(k));
    else
        e(k+1) = e(k);
        du(k+1) = du(k);
    end
    
    % saturação
    if dCa(k+1) > 10
        dCa(k+1) = 10;
    end
    if dCa(k+1) < 0
        dCa(k+1) = 0;
    end
    if dCb(k+1) > 10
        dCb(k+1) = 10;
    end
    if dCb(k+1) < 0
        dCb(k+1) = 0;
    end
    if du(k+1) > 10
        du(k+1) = 10;
    end
    if du(k+1) < 0
        du(k+1) = 0;
    end
    if dCaf(k+1) > 6
        dCaf(k+1) = 6;
    end
    if dCaf(k+1) < 4
        dCaf(k+1) = 4;
    end
    k=k+1;
end
t = -1*Tc:Tc:50;
figure;
hold on; grid on;
plot(t,dCa)
plot(t, dCb)
plot(t, Cb_ref)
plot(t, du)
plot(t, dCaf)
legend("Ca","Cb","Cb_ref","u","Caf")







