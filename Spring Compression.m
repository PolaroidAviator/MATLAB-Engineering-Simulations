clear
clc

%% Initialize

m = 1.0;  % (kg) mass of the car
g = 9.81; % (m/s^2) acceleration due to gravity
r = 0.94; % (m) radius of the loop
k = 1870; % (N/m) spring constant

%% Calculate

% state 1 is the moment the car is released
% state 2 is the moment the car is at the top of the loop

% use COE to solve for the distance the spring must be compressed
% such that the velocity at state 2 is enough to keep the car
% from falling, i.e. the normal acceleration must equal (or exceed)
% acceleration due to gravity.

h = 2*r;       % height of the car at state 2
v = sqrt(g*r); % velocity of the car at state 2

x = sqrt((m*v^2+2*m*g*h)/k); % use COE to solve for the distance spring has to be compressed 

