%% initialization
clear;
close all;
clc;

%% Reformat the figure format (uncomment it if you run it first time)
% figure_preprocessing

%% Read the new processed file and output the data and target
imgDataPath_processed = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
[X, y] = getimdata2(imgDataPath_processed);

%% transpose the X and y for easy manipulation
X = transpose(X);
y = transpose(y);

%% Seperate the data format in 8 : 2
[train_idx, test_idx] = crossvalind('HoldOut', y, 0.2);
X_train = X(train_idx,:);
X_test = X(test_idx,:);
y_train = ind2vec(y(train_idx,:)')';
y_test = ind2vec(y(test_idx,:)')';


%% The MLP model train NN

% neurons = 32;
lr_rate = 0.2;
mc_rate = 0.4;
epochs = 1000;

% nhidden = neurons; %number of hidden layers
net=newff(X_train',y_train',[100,100],{'tansig','tansig'},'traingdm');
% set the hyperparameter (epochs, learning rate)
net.trainParam.epochs = epochs; %number of training epochs
net.trainParam.lr = lr_rate;
net.trainParam.mc = mc_rate;
% train a neural network
[net,tr,Y,E] = train(net,X_train',y_train');
% predict the value
y_predict = sim(net,X_test');
% perf = perform(net, y_test', y_predict)
% fprintf('value of mse in neuron %d, learning rate %2.1f, momentum is %3.1f,is %6.4f\n ',neurons,lr_rate,mc_rate,perf);

%% test the performance
training_acc = rate(getcls(Y), y_train')
testing_acc = rate(getcls(y_predict), y_test')

%% transform to the vector format
y_predict_vec = vec2ind(y_predict);
y_test_vec = vec2ind(y_test');

%% Confusion mareix 
C = confusionmat(y_predict_vec,y_test_vec);
confusionchart(C)





