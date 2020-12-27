clc;clear;close;
%%
load test.mat
%%
tforT = y_train;
K = rbf_function;
% psedu = inv(corr);
weights=pinv(K'*K)*K'*tforT';

%% pseudo inverse
corr = K'*K;
psedu = pinv(corr)*K'