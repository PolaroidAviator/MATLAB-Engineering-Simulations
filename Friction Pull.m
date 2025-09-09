clear
clc

%% Initialize

u_k = 0.4;      % Coefficient of kinetic friction
u_s = 0.6;      % Coefficient of static friction
weight = 550;   % weight of block (N)
theta = 15;     % angle of pull force (deg from x)
g = 9.81;       % acceleration due to gravity (m/s^2)
% There are some value combinations (e.g. as theta approaches 90 degrees) that would result in 
% special cases: the horizontal pull force never exceeds Fmax, or 
% the vertical pull force exceeds the weight.  The reference implementation
% will issue warnings for these values. Your implementation does not need 
% to issue warnings or take any other special action under these conditions.

load('friction_pull_data.mat')

%% Pre-Calculate
% organize formulas that can be computed as array calculations here

nPts = length(time);
dT = max(diff(time));
mass = weight/g;
Px = pullForce*cosd(theta);
Py = pullForce*sind(theta);
Fnormal = weight-Py;
Fmax = u_s*Fnormal;

% Fstatic = Px
% Fkinetic = u_k*Fn
% ax = (Px-F)/m


%% Iterate

% initialize arrays that will be calculated in the loop
acc = nan(1,nPts);
vel = nan(1,nPts);

% assign initial values for t0
acc(1) = 0;
vel(1) = 0;
% start loop here

for idx = 2:nPts
    if vel(idx-1) > 0 || Px(idx-1) > Fmax(idx-1)
        Ffriction = u_k*Fnormal(idx);
    else
        Ffriction = Px(idx);
    end

    acc(idx) = (Px(idx)-Ffriction)/mass;
    vel(idx) = vel(idx-1) + acc(idx)*dT;



end

%% Output
% Always print the velocity value at 3 and 5 seconds.
% If the velocity at the final time is greater than 0, print that value
% along with the final time.
% otherwise, print the time at which velocity returns to zero
% The logical condition for "velocity returns to zero" is 
% diff(vel) < 0 & vel(2:end) <= 0
% read this as "the change in velocity is negative and velocity is less
% than or equal to zero" Note we need <= 0 because velocity will likely
% never be exactly zero due to how the simulation works.
% Format all velocity values to exactly 3 significant figures
% Format the time at which the block returns to rest with exactly 2 decimal places

fprintf("Velocity at 3 seconds is %.2f m/s \nVelocity at 5 seconds is %.2f m/s \n", vel(1,301), vel(1,501))
fprintf("The block stops moving at %.2f\n", time(find(diff(vel) < 0 & vel(2:end) <= 0, 1)+1))
%% Plot
% This section is complete. The conditionals are simply there so that the
% code will run without error during developing when you may not have yet
% created all necessary variables.

figure(1); clf

sgtitle('Block Kinematics');
subplot(3,1,3);
plot(time, pullForce, '.');
ylabel('Pull Force (N)');
xlabel('Time (s)');

subplot(3,1,2);
if exist('acc', 'var')
    plot(time, acc, '.');
else
    text(.1, .5, "No acceleration data yet");
end
ylabel('Acceleration (m/s^2)');

subplot(3,1,1);
if exist('vel', 'var')
    plot(time, vel, '.');
else
    text(.1, .5, "No velocity data yet");
end
ylabel('Velocity (m/s)');

