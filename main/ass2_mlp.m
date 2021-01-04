%% initialization
clear;
close all;
clc;
rng(1);
%% Uncomment it if you wish to rerun it again
% data_partition 

%% load the saved & splitted dataset
load train_test_data.mat 

%% The MLP model train NN

% neurons = 32;
lr_rate = 0.2;
mc_rate = 0.4;
epochs = 1000;

% nhidden = neurons; %number of hidden layers
net_mlp=newff(X_train',y_train',[50,100,100],{'tansig','tansig','tansig'},'traingdm');
% set the hyperparameter (epochs, learning rate)
net_mlp.trainParam.epochs = epochs; %number of training epochs
net_mlp.trainParam.lr = lr_rate;
net_mlp.trainParam.mc = mc_rate;
% train a neural network
[net_mlp,tr,Y,E] = train(net_mlp,X_train',y_train');
% predict the value
y_predict = sim(net_mlp,X_test');
% perf = perform(net, y_test', y_predict)
% fprintf('value of mse in neuron %d, learning rate %2.1f, momentum is %3.1f,is %6.4f\n ',neurons,lr_rate,mc_rate,perf);

view(net_mlp)
%% test the performance
training_acc = rate(getcls(Y), y_train')
testing_acc = rate(getcls(y_predict), y_test')

%% transform to the vector format
y_predict_vec = vec2ind(y_predict);
y_test_vec = vec2ind(y_test');

%% Confusion mareix 
C_mlp = confusionmat(y_predict_vec,y_test_vec);
confusionchart(C_mlp)

% save C_mlp.mat





