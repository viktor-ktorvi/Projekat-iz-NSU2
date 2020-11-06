clc;
close all;
clear variables;
%%
out = evalc('linearizacija_simbolicki');
clearvars -except G L R C E
s = tf('s');
%%
G
figure()
rlocus(G)
%%

w = 0:0.1:10000;
[re,im] = nyquist(G,w);
re = re(:);
im = im(:);

figure()
plot(re, im)
title("Nikvistova kriva")
xlabel("Re (\omega)")
ylabel("Im (\omega)")
grid on;
%%
figure()
nyquistplot(G, {0, inf})
axis equal
%% Inverzija dinamike na bazi pracenja reference

G
figure()
margin(G)
[w_z, gain] = zero(G)
poles = pole(G)
w_ogranicenje = w_z/2;
G_approx = zpk(-w_z, poles, gain)

w1 = w_ogranicenje
K = w1/s * G_approx^(-1)
W = minreal(K*G)

figure()
margin(W)


%% Simulacija

% sim_duration = 5; % sec
% sim_file_name = 'buck_boost_sim';
% open_system(sim_file_name)
% out = sim(sim_file_name);
%