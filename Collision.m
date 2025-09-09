clear; clc;

load('lab23_data');

%% Input
% display the menu
fprintf("Objects:\n" + ...
    "\t1 - billiard ball\n" + ...
    "\t2 - tennis ball\n" + ...
    "\t3 - clay ball\n");

% get object IDs
index1 = input("What is the index value of the first object? ");
index2 = input("What is the index value of the second object? ");

% get initial velocities
v1_i = input("Enter the initial velocity of the first object in m/s: ");
v2_i = input("Enter the initial velocity of the second object in m/s: ");


%% Get data out of input file using user's input
% the two masses:
m1 = objects.mass(index1);
m2 = objects.mass(index2);
% the coefficient of restitution: 
e = cors(index1, index2);

%% Construct augmented matrix
mtrx = [m1, m4, m1*v1_i + m2*v2_i;
        -1, 1,  e*(v1_i-v2_i)];

%% Solve for final velocity using the built-in rref function
soln_mtrx = rref(mtrx);
% for convenience and readability, store answer in well-named vars:
vl_f = soln_mtrx(1,3);
v2_f = soln_mtrx(2,3);

%% Pretty-print the answer
fprintf("In the collision between the two objects\n");
fprintf("the final velocity of the first object is %.2f m/s\n", v1_f);
fprintf("and the final velocity of the second object is %.2f m/s\n", v2_f);

