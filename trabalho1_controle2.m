%Trabalho1_controle 2
A = [[0 1];[0 0]];
b = [0;-0.294];
c = [1,0];
eig(A)
ctrb(A,b)
obsv(A,c)
%Controlador
ts = 3;
mp = 0.05;
zeta = -log(mp)/sqrt(pi^2 + (log(mp))^2)
wn = 4/(zeta*ts)
%Definindo zeta e omega n maiores que os encontrados
zeta_novo = 0.7;
wn_novo = 2.5;
%Descorindo os polos do sistema
raizes = roots([1,2*zeta_novo*wn_novo,wn_novo^2])
%Calculando o ganho
polos_desejados = [ -1.7500 + 1.7854i -1.7500 - 1.7854i];
kt =place(A,b,polos_desejados)
%Adicionando kp
ft_ee = ss(A-b*kt,b,c,0);
ganhocc = dcgain(ft_ee);
kp = 1/ganhocc

