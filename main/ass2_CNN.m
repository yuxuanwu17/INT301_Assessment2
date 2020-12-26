clc;
clear;
close all;

%% Read the data (This time we used the imds format to handle the figure)
F = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data'
imds = imageDatastore(F,'IncludeSubfolders',true,'LabelSource','foldernames');
%% Have a view of the inside component
% figure;                              
% perm = randperm(1000,20);           
% for i = 1:20
%     subplot(4,5,i);                 
%     imshow(imds.Files{perm(i)});    
% end

%% Have a view of the inside components
% Return the number of labels and corresponding counts
labelCount = countEachLabel(imds);
% labelCount

%% Divide the dataset into two parts (8:2)

numTrainFiles = 80;
[imdsTrain, imdsTest] = splitEachLabel(imds, numTrainFiles,'randomize');

%% Design the training layer components

layers = [
imageInputLayer([48 24 1])           

convolution2dLayer(3,8,'Padding',1)   
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)

convolution2dLayer(3,16,'Padding',1)  
batchNormalizationLayer
reluLayer
maxPooling2dLayer(2,'Stride',2)

convolution2dLayer(3,32,'Padding',1)  
batchNormalizationLayer
reluLayer

fullyConnectedLayer(24)               
softmaxLayer
classificationLayer];

%% Define the hyperparameters of layers

options = trainingOptions('sgdm','MaxEpochs',4,'ValidationData',imdsTest,'ValidationFrequency',30,'Verbose',false,'Plots','training-progress');
%% Train the network

net = trainNetwork(imdsTrain, layers, options);
%% Make the prediction on test dataset

YPred = classify(net,imdsTest);

%% Calculate the accuracy

YTrue = imdsTest.Labels;
accuracy = sum(YPred == YTrue)/numel(YTrue)

%% Confusion matrix 
C_CNN = confusionmat(YPred,YTrue);
confusionchart(C_CNN)