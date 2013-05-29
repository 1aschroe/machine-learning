function [ w, b ] = solveSVM( c, x, y )
%SOLVESVM Summary of this function goes here
%   Detailed explanation goes here

    [m, n] = size(x);

    cvx_quiet(true);
    cvx_begin
        variables w(n) b xi(m)
        minimize 1/2*sum(w.*w) + c*sum(xi)
        y.*(x*w + b) >= 1 - xi;
        xi >= 0;
    cvx_end
end

