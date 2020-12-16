%%
clc; 
clear; 

%% Read the new processed file and output the data and target
F = '/Users/yuxuan/Desktop/INT301_Assessment2/ass2data'
imds = imageDatastore(F,'IncludeSubfolders',true,'LabelSource','foldernames')

numTrainFiles = 80;
[imdsTrain, imdsTest] = splitEachLabel(imds, numTrainFiles,'randomize');


%%
layers = [
    imageInputLayer([48 24])

    convolution2dLayer(3,8,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    averagePooling2dLayer(2,'Stride',2)

    convolution2dLayer(3,16,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    averagePooling2dLayer(2,'Stride',2)
  
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    convolution2dLayer(3,32,'Padding','same')
    batchNormalizationLayer
    reluLayer
    
    dropoutLayer(0.2)
    fullyConnectedLayer(1)
    regressionLayer];
%%

options = trainingOptions('sgdm', ...
    'MaxEpochs',30, ...
    'InitialLearnRate',1e-3, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',20, ...
    'Shuffle','every-epoch', ...
    'ValidationData',{XValidation,YValidation}, ...
    'Plots','training-progress', ...
    'Verbose',false);
