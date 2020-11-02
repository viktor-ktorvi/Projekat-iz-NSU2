clc;
close all;
clear variables;
%%
L = 15.91e-3; % H
C = 470e-6; % F
R = 52; % Ohm
E = 12; % V
Vc = -22.5; % V

u = 0.3;
%%
sim_duration = 1; % sec
sim_file_name = 'buck_boost_sim';
open_system(sim_file_name);
sim(sim_file_name);