%% Exercise 1

n=10;

%% Section 1-7

sigmas = [0.01 0.1 0.4 0.9 1];
err_for_sigma = zeros(length(sigmas), 1);
for sigma = sigmas
    err_for_sigma(sigmas==sigma) = findAverageError(sigma, n, false);
end

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

f = @(x) 0;
for it=1:15
    f = f + w(it).*basis_fun{it};
end