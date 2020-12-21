%% initialization
clear;
close all;
clc;


%% Read the new processed file and output the data and target
imgDataPath_processed = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2_processed_data/';
[X, y] = getimdata(imgDataPath_processed);
%% 
X_trans = transpose(X);
y_trans = transpose(y);
%% split data into 8:2

rng(1)
[ndata, D] = size(X_trans);        %ndata，D: feature dimension
R = randperm(ndata);         %1到n randomize the number as index
num_test = floor(ndata*0.2);
X_test = X_trans(R(1:num_test),:);  
R(1:num_test) = [];
X_train = X_trans(R,:);          
num_training = size(X_train,1);

y_test = y_trans(R(1:num_test),:);
y_train = y_trans(R,:);

trainsamples= X_train;
trainlabels=y_train;
testsamples = X_test;
testlabels = y_test;
%%
numunits1 = 50;
numunits2 = 100
net = newff(trainsamples',trainlabels',[numunits1,numunits2],{},'traingdm');
net = init(net);
for i = 1:3
    net.layers{i}.transferFcn = 'tansig';
end
net.trainParam.epochs = 1000;
net.trainParam.lr = 0.1;
net.trainParam.mc = 0.3;
net = train(net,trainsamples',trainlabels');

testpred = getcls(sim(net, testsamples'));
% Calculate the accuracy rate: #correctly classified/#total
accuracy = rate(vec2ind(testlabels'),vec2ind(testpred));

% Calculate the mean squared error
performance = perform(net,testlabels',testpred);
