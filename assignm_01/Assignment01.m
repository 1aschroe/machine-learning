
% Section 1
n1 = 30;
train_data_class1 = rand(n1,2);
n2 = 30;
train_data_class2 = rand(n2,2) + ones(n2,2)*[1 0; 0 0];
train_data = [train_data_class1; train_data_class2];
train_label(1:n1) = 1;
train_label(n1+1:n2) = 2;

% Section 2
figure(1); clf; hold all; axis equal;
plot(train_data(1:n1,1), train_data(1:n1,2), 'r*');
plot(train_data(n1+1:n1+n2,1), train_data(n1+1:n1+n2,2), 'bo');