% Calculate kinetic, gravitational potential, and total mechanical energy
% of physics cart using position, velocity, and acceleration data loaded
% from data file.

clear; clc

%% Initialize
mass = 0.16;     % mass of cart (kg)
g = 9.81;        % acceleration due to gravity (m/s^2)
incline = 3.85;  % angle of incline (deg from horizontal)

%% Read
% load the data saved from the experiment.
% The data contains columns time, pos, vel, and acc
% with time, position, velocity, and acceleration data.
% All data use SI units.
cartData = readtable('cart_incline.csv');

%% Calculate

% The position data is relative to the start point
% which is the highest point on the incline.
% We shift the origin to make the y-component calculation
% easier.
posFromStart = max(cartData.pos) - cartData.pos;

% the height is the y-component of the position
% vector using posFromStart as the magnitude and `incline` as
% the angle of incline
height = posFromStart*sind(incline);

% From physics: Ug = mgh
cartData.energy_potential = mass*g*height;
% From physics: K = 0.5*m*v^2
cartData.energy_kinetic = 0.5*mass*cartData.vel.^2;
% From physics: Emech = Ug + K
cartData.energy_total = cartData.energy_potential + cartData.energy_kinetic;

%% Visualize
% To help understand the relationship between
% an objects position, velocity, and acceleration,
% we plot the values from the experiment on subplots
% with the time axis shared.

pva_plot = figure(1); clf
sgtitle('Cart Kinematics');
subplot(3,1,1);
plot(cartData.time, posFromStart, '.');
ylabel('Position (m)');

subplot(3,1,3);
plot(cartData.time, cartData.acc, '.');
ylabel('Acceleration (m/s^2)');
xlabel('Time (s)');

subplot(3,1,2);
plot(cartData.time, cartData.vel,'.');
ylabel('Velocity (m/s)');

% To help understand the relationship between
% kinetic, potential, and total energy,
% we plot these three values on the same
% axis.
energy_plot = figure(2); clf
hold on
plot(cartData.time, cartData.energy_kinetic, '.', 'DisplayName', 'Kinetic');
plot(cartData.time, cartData.energy_potential, '.', 'DisplayName', 'Potential');
plot(cartData.time, cartData.energy_total, '.', 'DisplayName', 'Total');

legend()
title('Cart Energy Comparison');
ylabel('Energy (J)');
xlabel('Time (s)');
