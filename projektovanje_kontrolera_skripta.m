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
figure()
margin(G)
w = 0:0.1:10000;
[re,im] = nyquist(G,w);
re = re(:);
im = im(:);
figure()
plot(re, im)
grid on
%%
% sim_duration = 30; % sec
% sim_file_name = 'buck_boost_sim';
% open_system(sim_file_name);
% sim(sim_file_name);