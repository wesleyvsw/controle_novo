%Declaração de variáveis
A = [[-3.333 0 -1.3333];[2 -2 0];[0 4.7727 -0.04545]];
b1 = [3.3333;0;0];
b2 = [0;0;-4.7727];
c = [0 0 1];
%Usando algebra linear, sem simplificação
%ft1 = c*inv(s*eye(3)-A)*b1;
%ft2 = c*inv(s*eye(3)-A)*b2;
%Usando as funções no matlab
sys_ss1 = ss(A, b1, c, 0);
sys_ss2 = ss(A, b2, c, 0);
ft_1 = tf(sys_ss1);
ft_2 = tf(sys_ss2);
%Encontrar eAt
%Importando os simbolos
syms s t
I = eye(size(A));
S = s*I - A;
inv_S = inv(S);
eAt = ilaplace(inv_S, s, t)
%Forma alternativa
eat2 = expm(A*t);
%Por funcao de transferencia
%Fc de transferencia completa
y_s = ft_1*tf([1],[1,0]) +ft_2*tf([1],[1,0])
% Extraindo os coeficientes do numerador e denominador
num_coeff = y_s.Numerator{1};  % Coeficientes do numerador
den_coeff = y_s.Denominator{1};  % Coeficientes do denominador
% Convertendo os coeficientes para uma expressão simbólica
num_sym = poly2sym(num_coeff, s);  % Numerador simbólico
den_sym = poly2sym(den_coeff, s);  % Denominador simbólico

% Criando a função de transferência simbólica
sys_sym = num_sym / den_sym;

disp('Função de Transferência Simbólica:');
disp(sys_sym);

% Calculando a transformada de Laplace inversa
y_t = ilaplace(sys_sym, s, t);

%Colocando tudo com 3 algarismos significativos
vpa(y_t,3);
%Plotando a resposta ao degrau
t = 0:0.01:10;   % Vetor de tempo
step(ft_1 + ft_2, t);    % Calculando e plotando a resposta ao degrau
xlabel('Tempo (s)');
ylabel('Saída');
title('Resposta ao Degrau de uma Função de Transferência');
grid on;

%Observabilidade e Controlabilidade
%Controlabilidade
ctrb(A,b1);
rank(ctrb(A,b1));
ctrb(A,b2);
rank(ctrb(A,b2));
%Observabilidade
c1 = [1 0 0];
c2 = [0 1 0];
c3 = [0 0 1];
obsv(A,c1)
obsv(A,c2)
obsv(A,c3)
rank(obsv(A,c1))
rank(obsv(A,c2))
rank(obsv(A,c3))
