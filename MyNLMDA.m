clear all
close all
clc
load('data_xy.mat');
K = size(y,2);
X = x';
Y = y;
w = sum(Y);
l = sum(Y,2);
for k = 1:K
    mk(:,k) = X*Y(:,k)/w(k);
end
m = sum(X*Y,2)/sum(sum(Y));
X_tilde = X - m;
W = diag(w);
L = diag(l);
Sb = X_tilde*Y*inv(W)*Y'*X_tilde';
St = X_tilde*L*X_tilde';
Sw = St - Sb;
Sw_plus = pinv(Sw);
temp = Sw_plus*Sb;
[V,D] = eig(Sw_plus*Sb,'vector');
[~,ind] = sort(D,'descend');
r = 16;
U = V(:,ind(1:r));
Z = U'*X;
savefile = "MyZ.mat";
save(savefile, 'Z');