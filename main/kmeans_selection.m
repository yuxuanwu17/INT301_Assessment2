%% initialization
clear;
close all;
clc;
rng(1)
load train_test_data.mat 

%% Use parallel computing
stream = RandStream('mlfg6331_64');  % Random number stream
options = statset('UseParallel',1,'UseSubstreams',1,...
    'Streams',stream);

%% Kmeans analysis to find the center location
target = [];

for n_cluster=1:120
[idx, C,sumdist] = kmeans(X_train,n_cluster,'Options',options,'MaxIter',10000,...
    'Replicates',5);
[silh,h] = silhouette(X_train,idx);
target = [target mean(silh)];
end 
%%
[idx,num]=max(target) %% 22 is the choice
%%
idx = [1:120];
plot(idx', target')
