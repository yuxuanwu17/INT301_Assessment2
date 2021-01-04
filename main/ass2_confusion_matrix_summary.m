%% initialization
clear;
close all;
clc;
rng(1);

%% MLP
figure('Name','MLP','NumberTitle','off');
load C_mlp.mat
confusionchart(C_mlp)
fprintf('The MLP netork training and testing accuracy are: ');

training_acc
testing_acc

%% CNN
clear;
figure('Name','CNN','NumberTitle','off');
load C_CNN.mat
confusionchart(C_CNN)
fprintf('The CNN training and testing accuracy are: ');

accuracy

%% LVQ
figure('Name','LVQ','NumberTitle','off');
load C_lvq.mat
confusionchart(C_lvq)
fprintf('The lvq training and testing accuracy are: ');

training_acc
testing_acc

%% RBF_kmeans
figure('Name','RBF_kmeans','NumberTitle','off');
load C_rbf_kmeans.mat
confusionchart(C_rbf_kmeans)
fprintf('The RBF_kmeans training and testing accuracy are: ');

training_acc
testing_acc

%% RBF_SOM 
figure('Name','RBF_SOM','NumberTitle','off');
load C_rbf_som.mat
confusionchart(C_rbf_som)
fprintf('The RBF_SOM training and testing accuracy are: ');

training_acc
testing_acc