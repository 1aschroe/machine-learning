clear all; clc; clf;

%% Exercise 1
%% Sections 1-8:
doExercise1(30,30, 100);

%% Section 9
doExercise1(200,200, 100);

%% Section 10
% The error value for uneven classes always considerably bigger.
% The error value increases monotonically with respect to k.
doExercise1(1000,50, 100);


%% Exercise 2
clear all; clc;

%% Section 3
figure;
dig = reshape(train_data(1012,:),16,16);
imagesc(dig)
colormap('gray');

%% Sections 1,2,4
doExercise2(2, 3);

%% Section 5
doExercise2(3, 8);