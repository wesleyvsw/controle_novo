%Trabalho 2 controle 2
A =[[0 1 0];[981.0001 0 -2.8814];[0 0 -100]];
b = [0; 0; 100];
c = [1 0 0];
%Controlador
ts = 0.5;
mp = 0.05;
zeta = -log(mp)/sqrt(pi^2 + (log(mp))^2)
wn = 4/(zeta*ts)
%Definindo zeta e omega n maiores que os encontrados
zeta_novo = 0.7;
wn_novo = 15;
%Descorindo os polos do sistema
raizes = roots([1,2*zeta_novo*wn_novo,wn_novo^2])
%Vetor de ganhos
polos_desejados = [-10.5000+10.7121i -10.5000-10.7121i -100];
kt =place(A,b,polos_desejados)
%Controlador duas vezes mais rápido
polos_desejados_2 =polos_desejados*2;
kt2 = place(A,b,polos_desejados_2)
%Nbar
xo1 = [0;0;0];
ref = 0.001;
s_estados = ss(A-b*kt2,b,c,0);
ganhocc = dcgain(s_estados)
Nbar = 1/ganhocc
%Controlador Robusto
%Nova matriz 4x4 para o controlador robusto:
A_nova =[[0 1 0 0];[981.0001 0 -2.8814 0];[0 0 -100 0];[-1 0 0 0]];
b_nova =[0;0;100;0];
%Place para novos polos, utilizando os polos 2x mais rápidos
polos_robusto = [-21+21.42i -21-21.42i -200 -500 ]
kt_novo =  place(A_nova,b_nova,polos_robusto)% Os três primeiros elementos são kt e o ultimo elemento e ki
kt_novo_kt =kt_novo(1:3)
kii = kt_novo(4)
kii = kii*(-1)
%Observador de estados
%Novos polos  15 vezes maiores
polos_observador = [-315+321.3i  -315-321.3i -250]
%Realocando os polos do observador
vetor_obs = place(A', c',polos_observador)




