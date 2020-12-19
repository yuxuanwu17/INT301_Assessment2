clc;
clear;

%% 
F = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data'
imds = imageDatastore(F,'IncludeSubfolders',true,'LabelSource','foldernames')
%%
% figure;                              %打开figure界面
% perm = randperm(1000,20);           %从1-1000中任取20个数
% for i = 1:20
%     subplot(4,5,i);                  %将figure界面分割为4X5个小格，并选中第i个小格
%     imshow(imds.Files{perm(i)});     %在第i个小格上显示标号为i的图片
% end

%%
labelCount = countEachLabel(imds);   %统计imds中各标签值的图片数
labelCount

%%
numTrainFiles = 80;
[imdsTrain, imdsTest] = splitEachLabel(imds, numTrainFiles,'randomize');

%%
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

%%
options = trainingOptions('sgdm','MaxEpochs',4,'ValidationData',imdsTest,'ValidationFrequency',30,'Verbose',false,'Plots','training-progress');
%%

net = trainNetwork(imdsTrain, layers, options)
