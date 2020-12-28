%% initialization
clear;
close all;
clc;
rng(1)
load train_test_data.mat 

%% Kmeans analysis to find the center location
target = [];

for n_cluster=1:360
[idx, C,sumdist] = kmeans(X_train,n_cluster);

[silh,h] = silhouette(X_train,idx);
target = [target mean(silh)];
end 
%%
[idx,num]=max(target) %% 22 is the choice
%%
idx = [1:360];
plot(idx', target')
save kmeans_plot.mat
