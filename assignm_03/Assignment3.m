%% Exercise 1
% Number of runs to determine the average error for one simga.
n=1;

%% Section 1
% Description:
% genLinData generates a vector of n values between -2 and 1. Noise of
% amplitude sigma is added to each entry's value Y, which is the linear
% function -0.7*X + 1.

%% Section 2-7
% Create a vector with sigmas
sigmas = [0.01 0.1 0.4 0.9 1];
% Initialize the error result vector with 0 
err_for_sigma = zeros(length(sigmas), 1);
for sigma = sigmas
    % insert for each sigma the corresponding average error value
    err_for_sigma(sigmas==sigma) = findAverageError(sigma, n, false);
end

% Plot the average errors with respect to the sigma value 
figure;
plot(sigmas, err_for_sigma, 'b.-');


%% Section 8

err_for_sigma_2 = zeros(length(sigmas), 1);
for sigma = sigmas
    err_for_sigma_2(sigmas==sigma) = findAverageError(sigma, n, true);
end

figure;

plot(sigmas, err_for_sigma_2, 'b.-');

%% Exercise 2

profile on;

clear all;

load('dataRidge.mat');

%% Section 2

doExercise1(false, x_train, y_train, x_test, y_test);

%% Section 3

x_for_lls = zeros(50,15);
basis_fun = cell(15,1);
for it= 1:15
    basis_fun{it} = @(x) x.^it;
    x_for_lls(:,it) = basis_fun{it}(x_train);
end

w = LLS(x_for_lls, y_train);

xx = -1.5:0.01:2.5;

yy = zeros(1, length(xx));
for it=1:15 
    yy = yy + w(it)*basis_fun{it}(xx);
end

plot(xx, yy);

%% Section 4

% The class of functions that can be learned are polynomials up to degree
% 15.

%% Section 5
% see Ridge LLS

%% Section 6
clf; hold on;

plot(x_train, y_train, 'x');

doRidge(x_train, y_train, x_test, y_test, 0.0001, 'g');
doRidge(x_train, y_train, x_test, y_test, 0.1, 'r');
doRidge(x_train, y_train, x_test, y_test, 10, 'k');

%% Section 7

clf; hold on;

plot(x_train, y_train, 'x');
plot(x_test, y_test, 'o');

l_exp = -15:1;
err=zeros(length(l_exp), 1);

for it=1:length(l_exp);
    c = (it - 1)/length(l_exp);
    color = [c 0 1-c];
    % lambda runs from blue (small) to red (big)
    err(it) = doRidge(x_train, y_train, x_test, y_test, 2^l_exp(it), color);
end

figure
plot(l_exp, err);

%% Exercise 3

profile off;

p = profile('info');
profview(0,p)