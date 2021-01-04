%% initialization
clear;
close all;
clc;

%% Uncomment it if you wish to rerun it again
% data_partition 

%% load the saved & splitted dataset
load train_test_data.mat 

%% LVQ network
net = lvqnet(24); 
net.trainParam.epochs = 50;
[net,tr,Y] = train(net,X_train',y_train');
view(net)
%%
y_predict = sim(net,X_test');

%% test the performance
training_acc = rate(getcls(Y), y_train')
testing_acc = rate(getcls(y_predict), y_test')

%% transform to the vector format
y_predict_vec = vec2ind(y_predict);
y_test_vec = vec2ind(y_test');

%% Confusion matrix of the network lvqnet(24)
C_lvq = confusionmat(y_predict_vec,y_test_vec);
confusionchart(C_lvq)

% save C_lvq.mat

%% Confusion matrix of the lvqnet(360) (training time is long but with high performance)
load('lvq_360.mat')
confusionchart(C_lvq)
% save C_lvq.mat