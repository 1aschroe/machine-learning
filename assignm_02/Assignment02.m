clf;

%% Exercise 1
%doExercise1

%% Exercise 2
%% Section 1
[X,Y] = mixGaussian1d(1000,0.5,0.5,0,6,1,2);

doExercise2(X, Y);

% 0; 1; 2 in class 1
% 2.5; 3; 4; 5 in class 2

%% Section 7

[X,Y] = mixGaussian1d(1000,0.1,0.6,0,6,1,2);

doExercise2(X, Y);

% 0; 1 in class 1
% 2; 2.5; 3; 4; 5 in class 2

%% Section 8

[X,Y] = multimodal1d(3000);

doExercise2(X, Y);

% 0; 1; 6; 7 in class 1
% 2; 3; 4; 5 in class 2