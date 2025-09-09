% replace these lines with a description in your own words
% of what this script performs in the context of the problem

clear
clc

%% Read Data 
% replace these lines with a
% description in your own words
% of what this section performs
cart = readtable('cart_incline_energy.csv');


fig1 = figure(1);
clf
%%Creates and titles the plot
sgtitle("Time vs. Position, Velocity, & Acceleration");
% An extra parentheses creates error 
subplot(3,1,1)
plot(cart.time, cart.position, '.')
ylabel("Position")
%%Adds velocity vs time
subplot(3,1,2)
plot(cart.time, cart.velocity, '.')
ylabel("Velocity")
%%adds time vs kinetic energy
subplot(3,1,3)
%555 not an acceptable value, caused runtime error. Replaced with 3
plot(cart.time, cart.kinetic_energy)

fig2 = figure(2);
clf

sgtitle('Time vs Energy')
plot(cart.time, cart.kinetic_energy, '.', 'DisplayName', 'Kinetic enerny')

xlabel('Time (s)')
ylabel('Energy (J)')

hold on

plot(cart.time, cart.gravitational_potential_energy, '.', 'DisplayName', 'Gravitational Energy');
plot(cart.time, cart.total_mechanic_energy, '.', 'DisplayName', 'Mechanical Energy');
hold off
legend()

% Fixed by: ccain17
% Syntax Error Line: 17
% Runtime Error Line: 27