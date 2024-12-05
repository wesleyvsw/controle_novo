%Controlador
ts = 1;
mp = 0.05;
zeta = -log(mp)/sqrt(pi^2 + (log(mp))^2)
wn = 4/(zeta*ts)
%Definindo zeta e omega n maiores que os encontrados
zeta_novo = 0.7;
wn_novo = 6;
%Descorindo os polos do sistema
raizes = roots([1,2*zeta_novo*wn_novo,wn_novo^2])
%Calculo de novos polos para encontrar as constantes do sistema
polo_extra_1 = raizes(1)*10;
polo_extra_2 = raizes(1)*20;
vetor_polos_robusto = [raizes(1) raizes(2) real(polo_extra_1) real(polo_extra_2)]%Se eu não colocar os valores extras na forma real, o matlab retorna um problema, mas nao um erro.
%Novo sistema para a encontrar kt e ki
A = [[-3.333 0 -1.3333];[2 -2 0];[0 4.7727 -0.04545]];
b1 = [3.3333;0;0];
c = [0 0 1];
%Novo sistema para encontrar kt e ki
A_robusto = [[-3.333 0 -1.3333 0 ];[2 -2 0 0];[0 4.7727 -0.04545 0];[0 0 -1 0]];
b_robusto = [3.3333;0;0;0];
vetor_k = place(A_robusto,b_robusto, vetor_polos_robusto)
kt_novo_kt = vetor_k(1:3);
kii = vetor_k(4);
kii=kii*(-1);
