%% initialization
clear;
close all;
clc;
load train_test_data.mat 
rng(1);

%% Define the SOM network

dimensions = [18,20]; % creat a 18X20 neuron matrix %% sqrt(sqrt(1152)*5)=13
% net = selforgmap(dimensions);
coverSteps = 10; 
initNeighbor = 80; 
topologyFcn = 'hextop'; 
distanceFcn = 'dist';

net = selforgmap(dimensions,coverSteps,initNeighbor,topologyFcn,distanceFcn);
[net,tr] = train(net,X_train');

% save som_net_data.mat

%% RBF train the som network
% load som_net_data.mat

[ W, sigma, C ] = RBF_training_som( X_train, y_train, net );

%% Return the predicted results of X_train

y_train_pred = RBF_predict(X_train, W, sigma, C);

%% Return the predicted results of X_test

y_test_pred = RBF_predict(X_test, W, sigma, C);

%% Calculate the training and testing accuracy

training_acc = rate(getcls(y_train_pred'), y_train')
testing_acc = rate(getcls(y_test_pred'), y_test')

%%
y_pred = vec2ind(getcls(y_test_pred'));
y_test = vec2ind(y_test');
C = confusionmat(int64(y_pred'),int64(y_test));
confusionchart(C)

save C_rbf_som.mat

