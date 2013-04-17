function [ ] = doExercise2( X, Y )
%DOEXERCISE2 Summary of this function goes here
%   Detailed explanation goes here

clf;

%% Section 2
plot(X(Y==1), -0.01, 'rx')
hold on;
plot(X(Y==2), -0.02, 'bo')

%% Section 3
figure (1); hold all;
[countC,binsX] = hist(X,30);
PX = countC/size(X,1);
plot(binsX,PX,'g.-');

%% Section 4
countY1 = hist(X(Y==1),binsX);
PYX1 = countY1/size(X(Y==1),1);
plot(binsX, PYX1, 'r.-');
countY2 = hist(X(Y==2),binsX);
PYX2 = countY2/size(X(Y==2),1);
plot(binsX, PYX2, 'b.-');

%% Section 5
PY1 = size(X(Y==1),1)/size(X,1);
PY2 = size(X(Y==2),1)/size(X,1);

%% Section 6
PXY1 = PYX1 * PY1 ./ PX;
plot(binsX, PXY1, 'm.-');
PXY2 = PYX2 * PY2 ./ PX;
plot(binsX, PXY2, 'k.-');

%% Exercise 5 Section 4
lPYX1 = 1 * PXY1;
lPYX2 = 100 * PXY2;
nlPYX1 = lPYX1 ./ (lPYX1 + lPYX2);
nlPYX2 = lPYX2 ./ (lPYX1 + lPYX2);
plot(binsX, nlPYX1, 'mx:');
plot(binsX, nlPYX2, 'k*:');

end

