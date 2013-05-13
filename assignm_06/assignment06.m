%% Exercise 6

clear all;

addpath ..\assignm_05\cvx-1.22\cvx
addpath ..\assignm_05\cvx-1.22\cvx\structures
addpath ..\assignm_05\cvx-1.22\cvx\lib
addpath ..\assignm_05\cvx-1.22\cvx\functions
addpath ..\assignm_05\cvx-1.22\cvx\commands
addpath ..\assignm_05\cvx-1.22\cvx\builtins
cvx_quiet(true)

x = [-3 3;-3 2;-2 3;-1 1;1 3;2 2;2 3;3 1];
[n, m] = size(x);
y = [-1 -1 -1 -1 1 1 1 1]';
c = 1;

cvx_begin
    variables w(m) b xi(n)
    dual variable lambda
    minimize 1/2*sum(w.*w) + c/n*sum(xi)
    lambda : y.*(x*w + b) >= 1 - xi;
    xi >= 0;
cvx_end

%% Section 1 (find support vectors)

find(lambda > 10^(-6))

%% Section 2 (KKT)

find(lambda.*(y.*(x*w+b)-1+xi) > 10^(-6))

k = x*x';
cvx_begin
    variables alpha(n) %you don't have anything with size d
    maximize( sum(alpha) - 0.5*quad_form(y.*alpha,k) )
    alpha>=0;
    alpha<=c/n;
    alpha'*y==0;
cvx_end

%% Section 3 (lambda == alpha)

find(lambda - alpha > 10^(-4))

%% Section 4 (reconstruct w and b)

w_reconstr = sum((alpha.*y)*ones(1,2).*x,2);

non_null_alpha = find(alpha > 10^(-6));
b_reconstr = 1/y(non_null_alpha(1)) -w'*x(non_null_alpha(1),:)';