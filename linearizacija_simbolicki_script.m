%% Linearizacija sistema

clc;
close all;
clear variables;
%% Jednačine sistema

syms x1 x2 R L C u E
f(1) = (x2 - u*x2 + u*E) / L;
f(2) = (-x1 + x1*u - x2/R) / C;
%% Ravnotežna stanja

sol = solve(f == 0, [x1,x2]);
%% 
% Struja kalema

x1e = sol.x1;
%% 
% Napon kondenzatora

x2e = sol.x2;
%% Linearizacija

A = jacobian(f, [x1, x2]);
B = jacobian(f, u);
% Karakteristični polinom

syms s
karakteristicni_polinom = simplifyFraction(det(s*eye(length(A)) - A));
% Ue preko x2e

eqn = x2e;
clear x2e
syms x2e real
sol = solve(eqn == x2e, u, 'ReturnConditions',true);
sol.conditions;
ue = sol.u;
%%
karakteristicni_polinom = subs(karakteristicni_polinom, u, ue);
% Nule karakterističnog polinoma

sol = solve(karakteristicni_polinom == 0, s, 'ReturnConditions',true);
nule = sol.s;
% Zamena vrednosti

L = 15.91e-3; % H
R = 52; % Ohm
C = 470e-6; % F
E = 12; % V
x2e = -22.5; % V
%% 
% Nule su konjugovano kompleksne i u levoj 1poluravni

nule = eval(nule);
%% 
% Menjamo u, x1 i x2 sa ue, x1e i x2e

ue = eval(ue);
x1e = eval(subs(x1e, u, ue));
A;
A = double(eval(subs(A, u, ue)));
B;
B = double(eval(subs(B, [x1, x2], [x1e, x2e])));
H = [0 1];
%% Funkcija prenosa

% s = tf('s');
% minreal(zpk(eval(char(subs(G, [x1, x2, u], [x1e, x2e, ue])))))

[num, den] = ss2tf(A,B,H,0);
G = zpk(tf(num, den))